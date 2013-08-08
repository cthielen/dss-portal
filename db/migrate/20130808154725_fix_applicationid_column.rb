class FixApplicationidColumn < ActiveRecord::Migration
  def change
    rename_column :application_assignments, :application_id, :rm_application_id
  end
end
