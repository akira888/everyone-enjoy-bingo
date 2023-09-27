class User < ApplicationRecord
  has_many :players, dependent: :destroy, inverse_of: :user

  validates :name, presence: true
end
