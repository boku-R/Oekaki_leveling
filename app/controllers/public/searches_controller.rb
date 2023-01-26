class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "ユーザを検索する"
      @users = User.where(is_deleted: false).looks(params[:word]).page(params[:page])
    elsif @range == "投稿を検索する"
      @posts = Post.where(is_deleted: false).looks(params[:word]).page(params[:page])
    elsif @range == "タグを検索する"
      @tags = Tag.using_tags.looks(params[:word]).page(params[:page]).per(20)
    end
  end

end
