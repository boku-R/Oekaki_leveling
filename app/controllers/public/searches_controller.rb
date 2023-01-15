class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "ユーザを検索する"
      @users = User.looks(params[:word])
    elsif @range == "投稿を検索する"
      @posts = Post.looks(params[:word])
    elsif @range == "タグを検索する"
      # 検索結果画面でタグ一覧表示
      @tag_list = Tag.all
      # リンクを押されたタグを受け取る
      @tag = Tag.looks(params[:word])
      # 検索されたタグに紐づく投稿を表示
      # @posts = @tag.posts
    end
  end

end
