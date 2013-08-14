class AddBooleanDefaultsToApplicationAssignments < ActiveRecord::Migration
  def change
    change_column :application_assignments, :favorite, :boolean, :default => false
    change_column :application_assignments, :bookmark, :boolean, :default => false
    
    # change_column won't affect existing rows. Do so now.
    ApplicationAssignment.where(:favorite => nil).each do |assignment|
      assignment.favorite = false
      assignment.save
    end
    ApplicationAssignment.where(:bookmark => nil).each do |assignment|
      assignment.bookmark = false
      assignment.save
    end
  end
end
