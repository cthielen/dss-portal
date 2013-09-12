class AddIconPathToRmApplicationAttributes < ActiveRecord::Migration
  def change
    remove_column :rm_application_attributes, :image_file_name
    remove_column :rm_application_attributes, :image_content_type
    remove_column :rm_application_attributes, :image_file_size
    remove_column :rm_application_attributes, :image_updated_at
  end
end
