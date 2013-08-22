class RemoveIconColumnsFromRmApplicationAttributes < ActiveRecord::Migration
  def changae
    remove_column :rm_application_attributes, :image_file_name
    remove_column :rm_application_attributes, :image_content_type
    remove_column :rm_application_attributes, :image_file_name
    remove_column :rm_application_attributes, :image_updated_at
  end
end
