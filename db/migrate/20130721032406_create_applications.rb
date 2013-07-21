class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :position
      t.boolean :favorite
      t.integer :person_id
      t.string :type
      t.integer :type_id

      t.timestamps
    end
  end
end
