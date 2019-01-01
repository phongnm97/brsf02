class BookStatuesController < ApplicationController
  before_action :logged_in_user
  before_action :load_book_status except: :create
  def create
    @book_status = BookStatus.new(book_status_params)
    if(@book_status.save)
    respond_to do |format|
      format.html { redirect_to @book_status.book }
      format.js
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  def update
    if @book_status.update_attributes(book_status_params)
    respond_to do |format|
      format.html { redirect_to @book_status.book }
      format.js
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  def destroy
    if @book_status.destroy
        respond_to do |format|
      format.html { redirect_to @book_status.book }
      format.js
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
  end

  private:

  def book_status_params
    params.require(:book).permit(:book_id, :status)
  end

  def load_book_status
    @book_status BookStatus.user_book current_user.id book_status_params.book_id
  end

end
