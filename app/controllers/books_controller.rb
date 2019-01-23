class BooksController < ApplicationController
  load_and_authorize_resource
  def show; end

  def index
    @books = @books.search(search_params,current_user).paginate page: params[:page],
      per_page: Settings.books_index.perpage
    @book_statuses = current_user.book_statuses.where(book_id: @books.ids)
    @book_favorites = current_user.book_favorites.where(book_id: @books.ids)
  end

  private

  def search_params
    params.permit(:title, :category_id, :author,:status)
  end
end
