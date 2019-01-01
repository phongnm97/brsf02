class CategoriesController < ApplicationController
  before_action :load_category, except: [:index, :new, :create]
  before_action :logged_in_user, :admin_user, except: [:show, :index]
  def show
    return unless @category.nil?
    redirect_to root_path
  end

  def edit; end

  def update
    # load_user
    if @category.update_attributes(category_params) && @category.present?
      flash[:success] = t "flash.updated"
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "flash.deleted"
    elsif @category.nil?
      flash[:danger] = t "flash.nocategory"
    end
    redirect_to categories_path
  end

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t "flash.created"
      redirect_to @category
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def load_category
    @category = Category.find_by id: params[:id]
    flash[:danger] = t "flash.nocategory" if @category.nil?
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.notlogin"
    redirect_to login_url
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
