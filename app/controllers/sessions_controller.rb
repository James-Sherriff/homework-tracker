class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if(!user.calendar_channel_active) then
      service = Google::Apis::CalendarV3::CalendarService.new
      service.client_options.application_name = "Homework Tracker"
      service.authorization = current_user.oauth_token
      channel = Google::Apis::CalendarV3::Channel.new(address: "https://homework-tracker-app.herokuapp.com/notifications",id: current_user.uid, type: "web_hook")
      webhook = service.watch_event('primary', channel, single_events: true, time_min: Time.now.iso8601)
      user.calendar_channel_active = true
      user.save!
    end
    redirect_to homeworks_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
