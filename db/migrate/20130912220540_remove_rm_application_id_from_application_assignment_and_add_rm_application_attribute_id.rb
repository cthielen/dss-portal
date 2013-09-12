class RemoveRmApplicationIdFromApplicationAssignmentAndAddRmApplicationAttributeId < ActiveRecord::Migration
  def change
    remove_column :application_assignments, :rm_application_id
    add_column :application_assignments, :rm_application_attribute_id, :integer
  end
end
