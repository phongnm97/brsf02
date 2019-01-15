class BooksController < ApplicationController
  before_action :load_book, except: [:index, :new, :create]
  before_action :logged_in_user

  def show; end

  def index
    if params[:status_is] == "reading"
      @books = current_user.reading_books.search(params_book_search)
    elsif params[:status_is] == "as_read"
      @books = current_user.as_read_books.search(params_book_search)
    else
      @books = Book.search(params_book_search)
    end
    @books = @books.paginate(page: params[:page], per_page: Settings.users.index.per_page)
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "flash.nobook"
    redirect_to admin_books_path
  end

  def params_book_search
    params.permit :title_contains, :author_contains, :category_id_is
  end
end
