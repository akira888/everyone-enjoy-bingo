class CardLog < ApplicationRecord
  belongs_to :card

  scope :bingo_count, -> { where(action: :bingo).count }
  scope :one_left_count, -> { where(action: :one_left).count }
end
