class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: :show

  def show
    @activities = @user.activities.includes(:object, :likes).includes(comments: [:user]).paginate page: params[:page],
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

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.nouser"
    redirect_to root_path
  end
end
