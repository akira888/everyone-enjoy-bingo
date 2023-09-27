class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user, inverse_of: :players
  accepts_nested_attributes_for :user
  before_validation :set_url_hash, on: :create

  validates :game_id, presence: true
  validates :user_id, presence: true
  validates :url_hash, presence: true, uniqueness: true

  def to_param
    url_hash
  end

  private

  def set_url_hash
    self.url_hash = unique_url_hash(:url_hash)
  end

  def unique_url_hash(field)
    hash = SecureRandom.urlsafe_base64(8)

    Player.find_by(field => hash) ? unique_url_hash(field) : hash
  end
end
