class Award < ApplicationRecord
  belongs_to :game, inverse_of: :award
end
