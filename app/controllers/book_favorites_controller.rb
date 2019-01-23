class BookFavoritesController < ApplicationController
  load_and_authorize_resource
  def create
    @book_favorite =  current_user.book_favorites.build book_favorite_params
    if @book_favorite.save
      respond_to do |format|
        format.html { redirect_to books_path }
        format.js
      end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to books_path
    end
  end


  def destroy
    @book = @book_favorite.book
    if @book_favorite.destroy
        respond_to do |format|
          format.html { redirect_to @book_favorite.book }
          format.js
        end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  private

  def book_favorite_params
    params.permit(:book_id)
  end
end
