class HomeworksController < ApplicationController
  
  def index
    if current_user then
      @homeworks = Homework.where("user = '" + "106217558654354167701" + "'")
      @homework = Homework.find(1)
    else
      redirect_to root_path
    end
  end
  
  def new
    @homeworks = Homework.where("user = '" + "106217558654354167701" + "'")
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
        redirect_to @homework
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end
  
  private
  def homework_params
    params.require(:homework).permit(:title, :content, :file_link);
  end
end