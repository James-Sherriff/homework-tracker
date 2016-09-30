class AddCalendarSyncNeededToUser < ActiveRecord::Migration
  def change
    add_column :users, :calendar_sync_needed, :boolean
  end
end
