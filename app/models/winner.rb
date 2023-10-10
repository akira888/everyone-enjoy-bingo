class Winner < ApplicationRecord
  belongs_to :game
  belongs_to :award, optional: true
  belongs_to :user

  validates :game_id, presence: true
  validates :user_id, presence: true
end
