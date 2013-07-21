class CreateBookmarkAssignments < ActiveRecord::Migration
  def change
    create_table :bookmark_assignments do |t|
      t.integer :bookmark_id
      t.string :loginid

      t.timestamps
    end
  end
end
