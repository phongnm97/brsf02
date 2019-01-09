class BooksController < ApplicationController
  before_action :load_book, except: [:index, :new, :create]

  def show; end

  def index
    @books = Book.search(params_book_search).paginate page: params[:page], per_page: Settings.users.index.per_page
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
