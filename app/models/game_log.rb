class GameLog < ApplicationRecord
  belongs_to :game

  after_create_commit -> { broadcast_prepend_to "emit-number-#{game.to_param}", target: "emit-numbers", partial: "game_logs/game_log" }

  validates :emit_number, presence: true, uniqueness: { scope: :game_id }

  scope :emit_numbers, -> { pluck(:emit_number) }

  scope :recent, -> { order(created_at: :desc) }
end
