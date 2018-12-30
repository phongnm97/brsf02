class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, except: [:index, :new, :create]
  before_action :admin_user, only: :destroy
  def show
    return unless @user.nil?
    redirect_to root_path
  end

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  def edit
    redirect_to login_path if @user.nil?
  end

  def update
    # load_user
    if @user.update_attributes(user_params) && @user.present?
      flash[:success] = t "flash.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.deleted"
    elsif @user.nil?
      flash[:danger] = t "flash.delete_fail"
    end
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t "flash.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.notlogin"
    redirect_to login_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    flash[:danger] = t "flash.nouser" if @user.nil?
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
