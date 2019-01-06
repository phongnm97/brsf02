class FavoriteBooksController < ApplicationController
  before_action :logged_in_user
  before_action :load_book_favorite except: :create
  def create
    @book_favorite = BookFavorite.new(book_favorite_params)
    if(@book_favorite.save)
    respond_to do |format|
      format.html { redirect_to @book_favorite.book }
      format.js
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  def destroy
    if @book_favorite.destroy
        respond_to do |format|
      format.html { redirect_to @book_favorite.book }
      format.js
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
  end

  private:

  def book_favorite_params
    params.require(:book).permit(:book_id, :status)
  end

  def load_book_favorite
    @book_favorite BookFavorite.user_book current_user.id book_favorite_params.book_id
  end

end
