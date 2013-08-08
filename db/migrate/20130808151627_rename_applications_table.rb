class RenameApplicationsTable < ActiveRecord::Migration
    def change
        rename_table :applications, :application_assignments
    end 
 end

