class RenameRmApplicationAttributeToCachedApplicationAndAdjustOtherColumnsAccordingly < ActiveRecord::Migration
  def change
    rename_table :rm_application_attributes, :cached_applications
    rename_column :application_assignments, :rm_application_attribute_id, :cached_application_id
  end
end
