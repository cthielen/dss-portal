class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :description
      t.date :published
      t.string :guid

      t.timestamps
    end
  end
end
