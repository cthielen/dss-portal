class AddIconPathColumnToRmApplicationAttributes < ActiveRecord::Migration
  def change
    add_column :rm_application_attributes, :icon_path, :string
  end
end
