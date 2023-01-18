class Admin::PostCommentsController < ApplicationController

  def restore
    post_comment = PostComment.find(params[:id])
    post_comment.is_deleted = false
    post_comment.save
    redirect_to admin_post_path(params[:post_id])
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.is_deleted = true
    post_comment.save
    redirect_to admin_post_path(params[:post_id])
  end

  private

  def post_params
    params.require(:post_comment).permit(:comment,:is_deleted)
  end

end
