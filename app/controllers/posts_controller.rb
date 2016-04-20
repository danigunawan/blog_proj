class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    # we need to define a new `Question` object in order to be able to
    # properly generate a form in Rails
    # Question is the ActiveRecord model
    @post = Post.new
  end

  def create

    post_params = params.require(:post).permit([:title, :body])
    @post       = Post.new(post_params)

    if @post.save
      #render text: "SUCCESS"
      #render :show
      #redirect_to question_path({id: @question.id})
      #redirect_to question_path({@question.id})
      redirect_to post_path(@post)
    else
      # this will render `app/views/questions/new.html.erb` because the default
      # in this action is to render `app/views/questions/create.html.erb`
      render :new

    end
  end

  # we receive a request such as : GET /questions/56
  # params[:id] will be `56`
  def show
    @post = Post.find params[:id]
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post       = Post.find params[:id]
    post_params = params.require(:post).permit(:title, :body)
    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

end
