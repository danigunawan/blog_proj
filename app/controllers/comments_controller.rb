class CommentsController < ApplicationController
  def created
    @post             = Post.find params[:post_id]
    comment_params    = params.require(:comment).permit(:body)
    @comment          = Comment.new comment_params
    @comment.post     = @post
    if @comment.save
      redirect_to post_path(@posts), notice: "Comment created"
    else
      render "/posts/show"
    end
  end
end
