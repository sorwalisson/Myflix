class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  #before_action :displayerror1

  def displayerror1
    unless current_user.active? #if the user is not active he cannot acess the content
      render json: {error: "inactive user, check your profile page"}, status: 442
    end
  end

  def msgnotadmin
    render json: {sucess: "Only admins may acess this section"}
  end

  def check_admin
    return msgnotadmin() unless current_user.admin?
  end
end
