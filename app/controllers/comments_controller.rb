class CommentsController < ApplicationController
  before_action :load_comment, except: [:index, :new, :create]
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:edit, :destroy, :update]

  def create
    @comment =  current_user.comments.build(comment_params)

    if(@comment.save)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = t "flash.noactivity"
      redirect_to root_path
    end
  end

  def update
    if @comment.update_attribute(:content, params["comment-content"])
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  def destroy
    @parent_activity = {id: @comment.parent_id, comments_count: (@comment.parent_activity.comments.count-1)}
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:parent_id, :content)
  end

  def correct_user
    return if current_user?(@comment.user)
    flash[:danger] = t "flash.wronguser"
    redirect_to root_path
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    redirect_to root_path
    flash[:danger] = t "flash.wronguser"
  end
end

