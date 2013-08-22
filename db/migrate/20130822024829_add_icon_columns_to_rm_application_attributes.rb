class AddIconColumnsToRmApplicationAttributes < ActiveRecord::Migration
  def change
    add_attachment :rm_application_attributes, :image
  end
end
