class Owner < ApplicationRecord
  belongs_to :game, inverse_of: :owner
end
