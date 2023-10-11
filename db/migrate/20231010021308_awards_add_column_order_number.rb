class AwardsAddColumnOrderNumber < ActiveRecord::Migration[7.0]
  def change
    add_column :awards, :order_number, :integer, null: false, default: 1
  end
end
