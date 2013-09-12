class DropImageFromApplicationAssignments < ActiveRecord::Migration
  def change
    remove_column :application_assignments, :image
  end
end
