class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email_address, index: { unique: true }
      t.string :hashed_password

      t.timestamps
    end
  end
end
