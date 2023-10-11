class WinnersRemoveColumnAwardId < ActiveRecord::Migration[7.0]
  def change
    remove_column :winners, :award_id
  end
end
