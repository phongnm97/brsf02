class AdminController < ApplicationController
  load_and_authorize_resource
  before_action :check_admin

  def check_admin
    authorize! :manage, :all
  end

end
