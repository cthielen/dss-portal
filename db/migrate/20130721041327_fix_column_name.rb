class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :applications, :type, :category_type
    rename_column :applications, :type_id, :category_id
  end
end
