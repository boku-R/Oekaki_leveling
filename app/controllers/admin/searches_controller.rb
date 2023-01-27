class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]

    if @range == "ユーザを検索する"
      @users = User.looks(params[:word]).page(params[:page])
    elsif @range == "投稿を検索する"
      @posts = Post.looks(params[:word]).page(params[:page])
    elsif @range == "タグを検索する"
      @tags = Tag.looks(params[:word]).page(params[:page]).per(20)
    end
  end

end
