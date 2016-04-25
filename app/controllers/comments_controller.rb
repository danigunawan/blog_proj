class CommentsController < ApplicationController

  def create
    @post             = Post.find params[:post_id]
    comment_params    = params.require(:comment).permit(:body)
    @comment          = Comment.new comment_params
    @comment.post     = @post
    if @comment.save
      redirect_to post_path(@post), notice: "Comment created"
    else
      render "/posts/show"
    end
  end

  def edit
    redirect_to root_path, alert: "can't do that" unless can? :edit, @comment
  end

  def update
    redirect_to root_path, alert: "can't do that" unless can? :update, @comment
    if @comment.update comment_params
      redirect_to @comment, notice: "Comment Updated"
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: "nah nah" unless can? :destroy, @comment
    @comment.destroy
    redirect_to post_path, notice: "Comment Deleted"
  end
end

private

def comment_params
  params.require(:post).permit(:body)
end
