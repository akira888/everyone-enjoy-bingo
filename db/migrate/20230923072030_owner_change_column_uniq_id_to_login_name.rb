class OwnerChangeColumnUniqIdToLoginName < ActiveRecord::Migration[7.0]
  def up
    remove_column :owners, :uniq_id, :string
    add_column :owners, :name, :string, null: false, default: "", after: :game_id
    add_index :owners, :name, unique: true
  end

  def down
    remove_column :owners, :name, :string
    add_column :owners, :uniq_id, :string, null: false, default: "", after: :game_id
    add_index :owners, :uniq_id, unique: true
  end
end
