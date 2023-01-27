class Admin::PostsController < ApplicationController
  # 管理者だけが管理者機能を使えるようにする
  before_action :authenticate_admin!

  def index
    @posts = Post.all.page(params[:page])
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    # 投稿主のユーザ
    @user = User.find(@post.user_id)
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    # illust.stepに投入するための変数をここで準備
    @illust_step = 0
    @tag_list = @post.tags.pluck(:name).join(' ')
  end

  def update
    @post = Post.find(params[:id])
    # 受け取った値をスペースで区切って配列に変換
    tag_list = params[:post][:name].split
    if @post.update(post_params)
      @post.save_tag(tag_list)
      flash[:notice] = "投稿は編集されました"
      redirect_to admin_post_path(@post.id)
    else
      flash[:notice] = "投稿を編集できませんでした"
      redirect_to admin_post_path(@post.id)
    end
  end

  # タグ検索
  def search_tag
    # すべてのタグを格納
    @tag_list = Tag.all.order(id: :desc).limit(15)
    # リンクを押されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    # 検索されたタグに紐づく投稿を表示
    @posts = @tag.posts.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title,:introduction,:user_id, :is_deleted, illusts_attributes: [:id, :post_id, :step, :illust_image])
  end

end
