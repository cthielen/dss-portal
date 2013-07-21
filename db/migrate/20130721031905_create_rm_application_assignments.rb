class CreateRmApplicationAssignments < ActiveRecord::Migration
  def change
    create_table :rm_application_assignments do |t|
      t.integer :application_id
      t.string :loginid

      t.timestamps
    end
  end
end
