class CreateSupplies < ActiveRecord::Migration[6.1]
  def change
    create_table :supplies do |t|
      t.belongs_to :product
      t.belongs_to :stock
      t.integer :count
      t.text :description

      t.timestamps
    end
  end
end
