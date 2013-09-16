class RenameRmApplicationIdToRmIdInCachedApplications < ActiveRecord::Migration
  def change
    rename_column :cached_applications, :rm_application_id, :rm_id
  end
end
