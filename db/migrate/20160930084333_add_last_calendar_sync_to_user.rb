class AddLastCalendarSyncToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_calendar_sync, :datetime
  end
end
