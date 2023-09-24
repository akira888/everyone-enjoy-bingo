class Game < ApplicationRecord
  include AASM

  has_many :awards, dependent: :destroy
  has_one :owner, dependent: :destroy
  accepts_nested_attributes_for :awards
  before_validation :set_url_hashes, on: :create

  validates :title, presence: true, length: { maximum: 255 }
  validates :max_winners, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
  validates :max_players, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates :entry_period_minutes, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 30 }
  validates :random_awards, inclusion: { in: [true, false] }
  validates :players_url_hash, presence: true, uniqueness: true
  validates :owners_url_hash, presence: true, uniqueness: true

  enum status: { not_started: 0, wait_entry: 1, playing: 2, finished: 3 }

  # URLでのアクセスをIDではなくハッシュ値で行う
  def to_param
    owners_url_hash
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
