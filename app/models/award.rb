class Award < ApplicationRecord
  belongs_to :game, inverse_of: :awards

  validates :title, presence: true, length: { maximum: 255 }
end
