class CreateAwards < ActiveRecord::Migration[7.0]
  def change
    create_table :awards do |t|
      t.references :game, null: false, foreign_key: true
      t.string :title, null: false

      t.timestamps
    end
  end
end
