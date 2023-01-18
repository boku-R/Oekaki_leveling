class Admin::SearchesController < ApplicationController
    before_action :authenticate_admin!

    def search
    @range = params[:range]

    if @range == "ユーザを検索する"
      @users = User.looks(params[:word]).page(params[:page])
    elsif @range == "投稿を検索する"
      @posts = Post.looks(params[:word]).page(params[:page])
    elsif @range == "タグを検索する"
      # 検索結果画面でタグ一覧表示
      @tags = Tag.looks(params[:word]).page(params[:page])
    end
  end

end
