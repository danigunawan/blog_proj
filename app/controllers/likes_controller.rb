class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @liked_posts = current_user.liked_posts.all
  end

  def create
    like          = current_user.likes.new
    post          = Post.find params[:post_id]
    like.post     = post
    if like.save
      LikesMailer.notify_post_owner(like).deliver_now
      redirect_to post, notice: "Liked"
    else
      redirect_to post, alert: "Can't like!"
    end
  end

  def destroy
    like = current_user.likes.find params[:id]
    post          = Post.find params[:post_id]
    like.destroy
    redirect_to like.post, notice: "Unliked"
  end
end
