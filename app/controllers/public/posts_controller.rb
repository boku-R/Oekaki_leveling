class Public::PostsController < ApplicationController
  before_action :ensure_deleted_post, only: [:show, :edit]
  # ログインしていない状態のアクセスを制限する
  before_action :authenticate_user!

  def new
    @post = Post.new
    # illust.stepに投入するための変数をここで準備
    @illust_step = 0
    # ４つのイラスト投稿の箱を作る
    4.times {
      @post.illusts.build
    }
    # タグの箱を作る
    @post.tags.new
  end

  def index
    # 論理削除された投稿を除外
    @posts = Post.order(created_at: :desc).where(is_deleted: false).page(params[:posts_page])
    @tag_list = Tag.using_tags
  end

  def show
    @post = Post.find(params[:id])
    # 投稿主のユーザ
    @user = User.find(@post.user_id)
    @post_comment = PostComment.new
    @post_tags = @post.tags
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 受け取った値を","で区切って配列に変換
    tag_list = params[:post][:name].split
    if @post.save
      @post.save_tag(tag_list)
      flash[:notice] = "投稿は保存されました"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "投稿を保存できませんでした"
      redirect_to new_post_path
    end
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
      redirect_to post_path(@post.id)
    else
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.is_deleted = true
    post.save
    redirect_to posts_path
  end

  # タグ検索
  def search_tag
    # 検索結果画面でタグ一覧表示（投稿に紐づいていない、また紐づいた投稿が削除されたタグを除外し、新規に登録されたタグ15件まで表示）
    @tag_list = Tag.using_tags.order(created_at: :desc).limit(15)
    # リンクを押されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    # 検索されたタグに紐づく投稿を表示（削除済みの投稿を除く）
    @posts = @tag.posts.where(is_deleted: false).page(params[:posts_page])
  end

  private

  def post_params
    params.require(:post).permit(:title,:introduction,:user_id, :is_deleted, illusts_attributes: [:id, :post_id, :step, :illust_image])
  end

  # ログイン中のユーザと、ユーザページで表示しているユーザが異なるときの権限の設定
  def ensure_deleted_post
    @post = Post.find(params[:id])
    if @post.is_deleted == true
      flash[:notice] = "指定した記事は削除されております"
      redirect_to posts_path
    end
  end
end
