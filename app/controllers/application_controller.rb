class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #before_action :displayerror1

  def displayerror1
    unless current_user.active? #if the user is not active he cannot acess the content
      render json: {error: "inactive user, check your profile page"}, status: 442
    end
  end

  def displayerror2
    render json: {error: "No title found!"}, status: 442 #when there is no title found with the params required.
  end

  def sucessmsg(source) #in case the review is saved
    render json: {sucess: "The #{source} was created sucessfully"}
  end
  
  def failedmsg(source) #in case the review is not save
    render json: {error: "The #{source} was not saved"}, status: 442
  end

  def sucessupdate(source)
    render json: {sucess: "The #{source} was updated sucessfully"}
  end

  def failedupdate(source)
    render json: {error: "The #{source} review was not updated"}
  end

  def destroysucces(source)
    render json: {sucess: "The #{source} was destroyed sucessfully"}
  end
end
