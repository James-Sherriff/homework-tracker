class AddCalendarChannelActiveToUser < ActiveRecord::Migration
  def change
    add_column :users, :calendar_channel_active, :boolean
  end
end
