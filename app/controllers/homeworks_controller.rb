require 'google/apis/calendar_v3'
require 'googleauth'

class HomeworksController < ApplicationController
  
  def index
    if current_user then
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
    @homework = Homework.new
    @homework.title = "From noficiation"
    @homework.content = "dadwadafsfadwadad"
    puts params.inspect
    puts "Without key - " + request.headers.to_s
    puts "With key - " + request.headers["X-Goog-Channel-ID"].to_s
    @homework.user = params["X-Goog-Channel-ID"]
    @homework.save
    redirect_to homeworks_path
  end
  
  private
  def homework_params
    params.require(:homework).permit(:title, :content, :file_link);
  end
end