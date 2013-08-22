class CreateRmApplicationAttributes < ActiveRecord::Migration
  def change
    create_table :rm_application_attributes do |t|
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
