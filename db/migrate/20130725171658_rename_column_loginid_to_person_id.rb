class RenameColumnLoginidToPersonId < ActiveRecord::Migration
  def change
    remove_column :bookmark_assignments, :loginid
    remove_column :rm_application_assignments, :loginid
    add_column :bookmark_assignments, :person_id, :integer
    add_column :rm_application_assignments, :person_id, :integer  
  end
end
