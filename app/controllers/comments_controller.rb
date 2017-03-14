class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_rating_user, only: :update

  def create
    @comment = Comment.new comment_params
    @success = true
    unless @comment.save
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @status = Settings.del_success_cmt
    if @comment
      unless @comment.destroy
        @status = Settings.del_fail_cmt
      end
    else
      @status = Settings.del_not_found_cmt
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :product_id, :user_id
  end
end
