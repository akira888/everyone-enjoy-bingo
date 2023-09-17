class Winner < ApplicationRecord
  belongs_to :game
  belongs_to :award
  belongs_to :user
end
