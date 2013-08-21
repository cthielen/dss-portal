class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.string :letter

      t.timestamps
    end
  end
end
