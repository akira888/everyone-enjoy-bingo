class Owner < ApplicationRecord
  has_secure_password

  belongs_to :game, inverse_of: :owner
end
