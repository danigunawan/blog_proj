class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.page params[:page]
  end

  def new
    # we need to define a new `Question` object in order to be able to
    # properly generate a form in Rails
    # Question is the ActiveRecord model
    @post = Post.new
  end

  def create
    @post       = Post.new(post_params)
    @post.user  = current_user
    if @post.save
      #render text: "SUCCESS"
      #render :show
      #redirect_to post_path({id: @post.id})
      #redirect_to post_path({@post.id})
      redirect_to posts_path, notice: "Post Created!"
    else
      # this will render `app/views/questions/new.html.erb` because the default
      # in this action is to render `app/views/questions/create.html.erb`
      flash[:alert] = "Post didn't save!"
      render :new
    end
  end

  # we receive a request such as : GET /questions/56
  # params[:id] will be `56`
  def show
    @post = Post.find params[:id]
    @like = @post.like_for(current_user)
    @comment = Comment.new
  end

  def edit
    redirect_to root_path, alert: "didn't say magic word" unless can? :edit, @post
  end

  def update
    redirect_to root_path, alert: "access denied" unless can? :update, @post
    if @post.update post_params
      redirect_to @post, notice: "Post Updated"
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: "uhhmmm, no access" unless can? :destroy, @post
      @post.destroy
      redirect_to posts_path, notice: "Post Gone"
  end

private

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    post_params = params.require(:post).permit([:title, :body])
  end

end
