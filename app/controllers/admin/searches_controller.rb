class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]

    @users = User.order(created_at: :desc).looks(params[:word]).page(params[:users_page])
    @posts = Post.order(created_at: :desc).looks(params[:word]).page(params[:posts_page])
    @tags = Tag.order(created_at: :desc).looks(params[:word]).page(params[:tags_page]).per(20)
  end

end
