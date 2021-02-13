class AddTypeToSupplies < ActiveRecord::Migration[6.1]
  def change
    add_column :supplies, :type, :string
  end
end
