class CreateApplicationAssignments < ActiveRecord::Migration
  def change
    create_table :application_assignments do |t|
      t.string :loginid
      t.string :position
      t.binary :favorite
      t.binary :is_bookmark

      t.timestamps
    end
  end
end
