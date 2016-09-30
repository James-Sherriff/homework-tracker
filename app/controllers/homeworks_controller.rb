require 'google/apis/calendar_v3'
require 'googleauth'

class HomeworksController < ApplicationController
  
  def index
    #service = Google::Apis::CalendarV3::CalendarService.new
    #service.client_options.application_name = "Homework Tracker"
    #service.authorization = current_user.oauth_token
    #channel = Google::Apis::CalendarV3::Channel.new(id: "homework-tracker-channel",resource_id: "rPJMUDI0rrHhdRs1ICk090xwU2k")
    #service.stop_channel(channel)
    if current_user then
      if(current_user.calendar_sync_needed) then
        if(!current_user.last_calendar_sync.nil?) then
          @time = current_user.last_calendar_sync
        else
          @time = Time.now.iso8601
        end
        puts "Running calendar sync"
        service = Google::Apis::CalendarV3::CalendarService.new
        service.client_options.application_name = "Homework Tracker"
        service.authorization = current_user.oauth_token
        @response = service.list_events(calendar_id,max_results: 10,single_events: true,order_by: 'startTime',time_min: @time)
        puts @response
        current_user.last_calendar_sync = Time.now.iso8601
        current_user.calendar_sync_needed = false
        current_user.save!
      end
      @homeworks = Homework.where(user: current_user.uid)
    else
      redirect_to root_path
    end
  end
  
  def new
    if current_user then
      @homework = Homework.new
    else
      redirect_to root_path
    end
  end
  
  def show
    if current_user then
    @homework = Homework.find(params[:id])
    else
      redirect_to root_path
    end
  end
  
  def complete
    @homework = Homework.find(params[:id])
    @homework.completed = true
  end
    
  def destroy
    puts "Destroyed"
    Homework.find(params[:id]).destroy
    redirect_to homeworks_path
  end
  
  def create
    if current_user then 
      @homework = Homework.new(homework_params)
      @homework.user = current_user.uid
      if @homework.save
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end
  skip_before_filter  :verify_authenticity_token
  def notify
    @user = User.where(uid: request.headers["X-Goog-Channel-ID"].to_s)
    puts request.headers["X-Goog-Channel-ID"]
    @user.calendar_sync_needed = true
    @user.save!
    redirect_to homeworks_path
  end
  
  private
  def homework_params
    params.require(:homework).permit(:title, :content, :file_link);
  end
end