class ReviewsController < ApplicationController
  before_action :load_review, except: [:index, :new, :create]
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:edit, :destroy, :update]

  def show
    redirect_to root_path if @review.nil?
  end

  def edit; end

  def update
    if @review.update_attributes(review_params)
      flash[:success] = t "flash.updated"
      redirect_to @review
    else
      render :edit
    end
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to @review
    else
      render "static_pages/home"
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "flash.deleted"
    elsif @review.nil?
      flash[:danger] = t "flash.nobook"
    end
    redirect_to books_path
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    flash[:danger] = t "flash.noreview" if @review.nil?
  end

  def correct_user
    return if current_user?(@review.user)
    flash[:danger] = t "flash.wronguser"
    redirect_to root_path
  end

    def review_params
      params.require(:review).permit(:title, :content, :book_id, :stars )
    end
end
