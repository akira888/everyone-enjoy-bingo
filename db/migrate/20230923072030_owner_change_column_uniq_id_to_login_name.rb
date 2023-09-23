class OwnerChangeColumnUniqIdToLoginName < ActiveRecord::Migration[7.0]
  def change
    remove_column :owners, :uniq_id, :string
    add_column :owners, :login_name, :string, null: false, default: "", after: :game_id
    add_index :owners, :login_name, unique: true
  end
end
