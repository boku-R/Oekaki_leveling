class Public::HomesController < ApplicationController

  def top
    # 投稿・登録順が最近のものから順に表示
    @posts = Post.all.where(is_deleted: false).order(created_at: :desc).limit(10)
    @users = User.all.where(is_deleted: false).order(created_at: :desc).limit(5)
  end

  def about

  end

end
