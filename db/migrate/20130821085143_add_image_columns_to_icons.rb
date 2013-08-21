class AddImageColumnsToIcons < ActiveRecord::Migration
  def change
    add_attachment :icons, :image
  end
end
