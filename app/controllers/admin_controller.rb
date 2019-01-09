class AdminController < ApplicationController
  before_action :logged_in_user, :admin_user

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.notlogin"
    redirect_to login_url
  end
end
