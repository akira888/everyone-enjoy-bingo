class Card < ApplicationRecord
  belongs_to :player

  validates :player_id, presence: true
  validates :game_id, presence: true

  before_create :set_card_numbers

  private

  def set_card_numbers
    numbers = {}
    numbers[:b] = (1..15).to_a.sample(5).map(&:to_s)
    numbers[:i] = (16..30).to_a.sample(5).map(&:to_s)
    numbers[:n] = (31..45).to_a.sample(4).map(&:to_s).insert(2, 'x')
    numbers[:g] = (46..60).to_a.sample(5).map(&:to_s)
    numbers[:o] = (61..75).to_a.sample(5).map(&:to_s)

    self.numbers = Card.where(game_id: self.game_id, numbers: numbers).exists? ? set_card_numbers : numbers
  end
end
