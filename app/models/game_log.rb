class GameLog < ApplicationRecord
  belongs_to :game

  validates :emit_number, presence: true, uniqueness: { scope: :game_id }
end
