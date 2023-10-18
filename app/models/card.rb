class Card < ApplicationRecord
  include CardLineCountable

  belongs_to :player
  belongs_to :game, inverse_of: :cards
  has_many :card_logs, dependent: :destroy

  validates :player_id, presence: true
  validates :game_id, presence: true

  before_create :set_card_numbers

  scope :has_number, ->(k, v) { where("JSON_CONTAINS(numbers, ?, ?)", v.to_s, "$.#{k}") }

  def update_numbers(params)
    number = params[:number].to_i
    key = params[:key].to_s
    return false unless has_number?(key, number)
    return false unless emit_number?(number)

    numbers[key].map! { |v| v == number ? 'x' : v }

    save && count_up_marked_lines
  end

  def has_number?(key, number)
    Card.where(player_id: player_id).has_number(key, number).exists?
  end

  private

  def set_card_numbers
    numbers = {}
    numbers[:b] = (1..15).to_a.sample(5)
    numbers[:i] = (16..30).to_a.sample(5)
    numbers[:n] = (31..45).to_a.sample(4).insert(2, 'x')
    numbers[:g] = (46..60).to_a.sample(5)
    numbers[:o] = (61..75).to_a.sample(5)

    self.numbers = Card.where(game_id: self.game_id, numbers: numbers).exists? ? set_card_numbers : numbers
  end

  def numbers_in(number)
    case number
    when 1..15
      'b'
    when 16..30
      'i'
    when 31..45
      'n'
    when 46..60
      'g'
    when 61..75
      'o'
    else
      raise ArgumentError, "number must be between 1 and 75"
    end
  end

  def count_up_marked_lines
    count_marked_lines(numbers)
    count_up_bingo
    count_up_one_left
  end

  def count_up_bingo
    return true if new_bingo_lines == bingo_lines
    (new_bingo_lines - bingo_lines).times { card_logs.build(action: :bingo) }
    update(bingo_lines: new_bingo_lines)
  end

  def count_up_one_left
    return true if new_one_left_lines == one_left_lines
    if new_one_left_lines > one_left_lines
      (new_one_left_lines - one_left_lines).times { card_logs.build(action: :one_left) }
    end
    update(one_left_lines: new_one_left_lines)
  end

  def emit_number?(number)
    game.emit_number?(number)
  end
end
