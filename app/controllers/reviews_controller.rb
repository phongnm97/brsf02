class ReviewsController < ApplicationController
  load_and_authorize_resource
  def show
    @activity = @review.activity
    @comments = @activity.comments.includes(:user).paginate page: params[:page],
      per_page: Settings.comments.perpage
    @user = @review.user
    @book = @review.book
  end

  def edit; end

  def index
    @reviews = Review.newest.includes(:user, :book).paginate page: params[:page],
      per_page: Settings.users.perpage
  end

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
      redirect_to reviews_path
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.error"
      redirect_to reviews_path
    end

  end

  private

  def review_params
    params.require(:review).permit :title, :content, :book_id, :stars
  end
end
