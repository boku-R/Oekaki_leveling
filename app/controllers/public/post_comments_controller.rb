class Public::PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_params)
    comment.post_id = post.id
    comment.save
    # jsファイルに渡すインスタンス
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new
    # redirect_to post_path(post)
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.is_deleted = true
    post_comment.save
    # jsファイルに渡すインスタンス
    @post = post_comment.post
    @post_comment = PostComment.new
    # redirect_to post_path(params[:post_id])
  end

  private

  def post_params
    params.require(:post_comment).permit(:comment,:is_deleted)
  end

end
