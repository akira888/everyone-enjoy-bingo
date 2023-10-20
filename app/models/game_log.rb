class GameLog < ApplicationRecord
  belongs_to :game

  after_create_commit -> { broadcast_prepend_to game.emit_number_channel, target: "emit-numbers", partial: "game_logs/game_log" }
  after_create_commit -> { broadcast_prepend_to game.emit_number_channel, target: "card", partial: "shared/reload" }

  validates :emit_number, presence: true, uniqueness: { scope: :game_id }

  scope :emit_numbers, -> { pluck(:emit_number) }

  scope :recent, -> { order(created_at: :desc) }
end
