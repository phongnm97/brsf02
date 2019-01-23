class UsersController < ApplicationController
  load_and_authorize_resource
  def show
    @activities = @user.activities.newest.includes(:object, :likes).includes(comments: [:user]).paginate page: params[:page],
      per_page: Settings.users.index.per_page
    @favorite_books = @user.favorite_books
  end

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end
end
