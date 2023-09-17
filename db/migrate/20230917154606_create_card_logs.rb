class CreateCardLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :card_logs do |t|
      t.references :card, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
