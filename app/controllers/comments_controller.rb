class CommentsController < ApplicationController
  load_and_authorize_resource
  def create
    @comment =  current_user.comments.build comment_params
    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = t "flash.valid_comment"
      redirect_to root_path
    end
  end

  def update
    if @comment.update_attribute :content, params["comment-content"]
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = t "flash.valid_comment"
      redirect_to root_path
    end
  end

  def destroy
    @parent_activity_id = @comment.parent_id
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:danger] = t "flash.error"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:parent_id, :content)
  end
end

