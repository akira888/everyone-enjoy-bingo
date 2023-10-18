class CardLog < ApplicationRecord
  belongs_to :card

  after_create_commit -> { broadcast_update_to card.game.bingo_log_channel, target: "make-lines", partial: "games/make_lines", locals: { game: card.game } }

  scope :bingo_count, -> { where(action: :bingo).count }
  scope :one_left_count, -> { where(action: :one_left).count }

  after_create_commit -> { broadcast_prepend_to card.game.bingo_log_channel, target: "bingo-log" }

  enum action: { bingo: 'bingo', one_left: 'one_left' }
end
