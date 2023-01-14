class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "ユーザを検索する"
      @users = User.looks(params[:word])
    elsif @range == "投稿を検索する"
      @posts = Post.looks(params[:word])
    end
  end

end
