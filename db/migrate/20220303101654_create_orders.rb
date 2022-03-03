class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.integer :process
      t.belongs_to :currency
      t.integer :count
      t.belongs_to :user
      t.belongs_to :order
      t.timestamps
    end
  end
end
