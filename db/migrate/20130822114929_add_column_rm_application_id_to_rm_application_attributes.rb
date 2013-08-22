class AddColumnRmApplicationIdToRmApplicationAttributes < ActiveRecord::Migration
  def change
    add_column :rm_application_attributes, :rm_application_id, :integer
  end
end
