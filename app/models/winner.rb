class Winner < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one :award, inverse_of: :winner

  validates :game_id, presence: true
  validates :user_id, presence: true
end
