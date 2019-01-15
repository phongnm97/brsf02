class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @activities = current_user.feed.newest.paginate(page: params[:page])
  end

  def about; end

  def contact; end
end
