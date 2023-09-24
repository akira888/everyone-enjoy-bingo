class GameAddColumnEntryCloseAt < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :entry_close_at, :datetime, null: true, default: nil
  end
end
