class AddRmIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :rm_id, :integer
  end
end
