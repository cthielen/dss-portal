class DropNameUrlAndDescriptionFromApplicationAssignments < ActiveRecord::Migration
  def change
    remove_column :application_assignments, :name
    remove_column :application_assignments, :url
    remove_column :application_assignments, :description
  end
end
