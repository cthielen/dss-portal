class DropIconsTable < ActiveRecord::Migration
  def change
    drop_table :icons
  end
end
