class Admin::PostCommentsController < ApplicationController

  def restore
    post_comment = PostComment.find(params[:id])
    post_comment.is_deleted = false
    post_comment.save
    # jsファイルに渡すインスタンス
    @post = post_comment.post
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.is_deleted = true
    post_comment.save
    # jsファイルに渡すインスタンス
    @post = post_comment.post
  end

  private

  def post_params
    params.require(:post_comment).permit(:comment,:is_deleted)
  end

end
