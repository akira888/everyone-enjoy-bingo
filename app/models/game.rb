class Game < ApplicationRecord
  include AASM

  has_many :awards, dependent: :destroy
  has_one :owner, dependent: :destroy
  has_many :game_logs, dependent: :destroy
  has_many :players, dependent: :destroy
  has_many :cards, through: :players
  has_many :winners, dependent: :destroy

  accepts_nested_attributes_for :awards, allow_destroy: true

  before_validation :set_url_hashes, on: :create

  validates :title, presence: true, length: { maximum: 255 }
  validates :max_winners, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
  validates :max_players, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates :entry_period_minutes, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 30 }
  validates :random_awards, inclusion: { in: [true, false] }
  validates :need_bingo_lines, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 12 }
  validates :players_url_hash, presence: true, uniqueness: true
  validates :owners_url_hash, presence: true, uniqueness: true

  enum status: { before_entry: 0, entry: 1, playing: 2, finished: 3 }

  aasm column: :status do
    state :before_entry, initial: true, display: '受付前'
    state :entry, display: '受付中'
    state :playing, display: 'プレイ中'
    state :finished, display: '終了'

    event :waiting, before: -> { self.entry_close_at = (Time.now + 60 * self.entry_period_minutes).strftime '%F %H:%M:00' } do
      transitions from: :before_entry, to: :entry
    end

    event :start, before: -> { self.started_at = Time.current } do
      transitions from: :entry, to: :playing, success: -> { broadcast_update_to state_channel, target: "player-content", partial: "shared/reload" }
    end

    event :finish, before: -> { self.finished_at = Time.current } do
      transitions from: :playing, to: :finished
    end
  end

  # URLでのアクセスをIDではなくハッシュ値で行う
  def to_param
    owners_url_hash
  end

  def emit_number?(number)
    game_logs.where(emit_number: number).exists?
  end

  def over?
    return false unless playing?
    cards.where(bingo_lines: need_bingo_lines..).count >= max_winners
  end

  # 少しイレギュラーなことをしているので後でサービスクラスなどに移植する
  def present_award_to(winner)
    return false unless winner.present?

    if random_awards
      award = awards.not_present_yet.sample
    else
      award = awards.not_present_yet.order(:order_number).first
    end

    award.present_to(winner) if award.present?
  end

  def play_time
    Time.zone.at(finished_at - started_at)
  end

  def emit_number_channel
    "emit-number-#{to_param}"
  end

  def state_channel
    "state-#{to_param}"
  end

  private

  def set_url_hashes
    self.players_url_hash = unique_url_hash(:players_url_hash)
    self.owners_url_hash = unique_url_hash(:owners_url_hash)
  end

  def unique_url_hash(field)
    hash = SecureRandom.urlsafe_base64(8)

    Game.find_by(field => hash) ? unique_url_hash(field) : hash
  end
end
