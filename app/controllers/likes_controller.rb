class LikesController < ApplicationController
  load_and_authorize_resource
  def create
    @like =  current_user.likes.build(like_params)
    if(@like.save)
      respond_to do |format|
        format.html { redirect_to activitys_path }
        format.js
      end
    else
      flash[:danger] = t "flash.noboaok"
      redirect_to activitys_path
    end
  end

  def destroy
    @activity = @like.activity
    if @like.destroy
        respond_to do |format|
          format.html { redirect_to @like.activity }
          format.js
        end
    else
      flash[:danger] = t "flash.noactivity"
      redirect_to root_path
    end
  end

  private

  def like_params
    params.permit(:activity_id)
  end
end
