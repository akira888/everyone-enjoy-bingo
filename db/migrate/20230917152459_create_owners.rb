class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.references :game, null: false, foreign_key: true
      t.string :uniq_id, null: false
      t.string :hashed_password

      t.timestamps
    end
  end
end
