class CreateBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :balances do |t|
      t.belongs_to :product
      t.belongs_to :stock
      t.integer :count

      t.timestamps
    end
  end
end
