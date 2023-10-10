class Award < ApplicationRecord
  belongs_to :game, inverse_of: :awards

  validates :title, presence: true, length: { maximum: 255 }

  scope :not_present_yet, -> { where(winner_id: nil) }

  def present_to(winner)
    update!(winner_id: winner.id)
  end
end
