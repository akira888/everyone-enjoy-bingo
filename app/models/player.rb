class Player < ApplicationRecord
  belongs_to :game
  belongs_to :user, inverse_of: :players
  has_one :card, dependent: :destroy

  accepts_nested_attributes_for :user
  before_validation :set_url_hash, on: :create

  validates :game_id, presence: true
  validates :user_id, presence: true
  validates :url_hash, presence: true, uniqueness: true

  def bingo?
    card.reload && card.bingo_lines >= game.need_bingo_lines
  end

  def winner?
    game.winners.exists?(user_id: user.id)
  end

  # 後でサービスクラスなどに移植する
  def win!
    winner = game.winners.build(user_id: user.id)
    winner.save!
    # 即時付与する
    game.present_award_to winner
  end

  def award
    return nil unless winner?
    game.awards.find_by(winner_id: winner_id)
  end

  def to_param = url_hash

  private

  def set_url_hash
    self.url_hash = unique_url_hash(:url_hash)
  end

  def unique_url_hash(field)
    hash = SecureRandom.urlsafe_base64(8)

    Player.find_by(field => hash) ? unique_url_hash(field) : hash
  end

  def winner_id = game.winners.find_by(user_id: user.id).id
end
