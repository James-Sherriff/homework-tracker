class PagesController < ApplicationController
  require 'google/apis/calendar_v3'
  def create_channel
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = "Homework Tracker"
    service.authorization = current_user.oauth_token
    channel = Google::Apis::CalendarV3::Channel.new(address: "https://homework-tracker-app.herokuapp.com/notifications",id: current_user.uid, type: "web_hook")
    webhook = service.watch_event('primary', channel, single_events: true, time_min: Time.now.iso8601)
    puts webhook.methods.inspect
  end
end
