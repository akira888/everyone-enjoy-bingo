class GameLog < ApplicationRecord
  belongs_to :game

  validates :emit_number, presence: true, uniqueness: { scope: :game_id }

  scope :emit_numbers, -> { pluck(:emit_number) }

  scope :recent, -> { order(created_at: :desc) }
end
