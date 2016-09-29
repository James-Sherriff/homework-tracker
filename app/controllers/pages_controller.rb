class PagesController < ApplicationController
  def create_channel
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = "Homework Tracker"
    service.authorization = current_user.oauth_token
    channel = Google::Apis::CalendarV3::Channel.new(address: "https://lan-lounge.herokuapp.com/notifications",id: "lan-lounge-channel", type: "web_hook")
    webhook = service.watch_event('primary', channel, single_events: true, time_min: Time.now.iso8601)_to @homework
  end
end
