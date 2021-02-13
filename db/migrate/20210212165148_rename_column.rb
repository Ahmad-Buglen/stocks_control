class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :supplies, :type, :view
    rename_column :shipments, :type, :view
  end
end
