class AddImageColumnToApplicationAssignments < ActiveRecord::Migration
  def change
    add_column :application_assignments, :image, :string
  end
end
