class PostsController < ApplicationController
  before_filter :require_login
  
  #GET /posts -> list of posts
  def index
    @posts = current_user.posts
  end

  #GET /post/:id -> display post
  def show
    @post = current_user.posts.find_by_id(params[:id])
    redirect_to root_path, :alert => 'An error has occured.' unless @post
  end

  #GET /post/new -> html form for creating
  def new
    @post = Post.new()
  end

  #POST /posts -> create post
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    
    if @post.save
      redirect_to @post, :notice => 'Post successfully created.'
    else
      render :action => 'new', :alert => 'Post could not be created.' 
    end
  end

  #DELETE /post/:id -> remove post
  def destroy
    @post = current_user.posts.find_by_id(params[:id])
    if @post
      @post.destroy
      redirect_to posts_url, :notice => 'Post successfully destroyed.'
    else
      redirect_to root_path, :alert => 'An error has occured.'
    end
  end
  
  private
 
    def require_login
      redirect_to root_path, :alert => 'You must be logged in to access this page' unless logged_in?
    end
end
