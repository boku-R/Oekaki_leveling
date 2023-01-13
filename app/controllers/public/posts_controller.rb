class Public::PostsController < ApplicationController

  def new
    @post = Post.new
    # illust.stepに投入するための変数をここで準備
    @illust_step = 1
    # ４つのイラスト投稿の箱を作る
    4.times {
      @post.illusts.build
    }
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    # 投稿主のユーザ
    @user = User.find(@post.user_id)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿は保存されました"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "投稿を保存できませんでした"
      redirect_to new_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    # illust.stepに投入するための変数をここで準備
    @illust_step = 1
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿は編集されました"
      redirect_to post_path(@post.id)
    else
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:introduction,:user_id, illusts_attributes: [:id, :post_id, :step, :illust_image])
  end

end
