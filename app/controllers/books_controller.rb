class BooksController < ApplicationController
  before_action :load_book, except: [:index, :new, :create]

  before_action :logged_in_user, :admin_user, except: [:show, :index]
  def show
    return unless @book.nil?
    redirect_to root_path
  end

  def edit; end

  def update
    # load_user
    if @book.update_attributes(book_params) && @book.present?
      flash[:success] = t "flash.updated"
      redirect_to @book
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "flash.deleted"
    elsif @book.nil?
      flash[:danger] = t "flash.nobook"
    end
    redirect_to books_path
  end

  def index
    @books = Book.paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = t "flash.created"
      redirect_to @book
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :category_id, :publish_date,
      :pages_count)
  end

  def load_book
    @book = Book.find_by id: params[:id]
    flash[:danger] = t "flash.nobook" if @book.nil?
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
