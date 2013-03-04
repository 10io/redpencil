class PostsController < ApplicationController
  
  #GET /posts -> list of posts
  def index
    @posts = Post.all
  end

  #GET /post/:id -> display post
  def show
    @post = Post.find(params[:id])
  end

  #GET /post/new -> html form for creating
  def new
    @post = Post.new()
  end

  #POST /posts -> create post
  def create
    @post = Post.new(params[:post])
    
    if @post.save
      redirect_to @post, :notice => 'Post successfully created.'
    else
      render :action => 'new', :alert => 'Post could not be created.' 
    end
  end

  #DELETE /post/:id -> remove post
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    redirect_to posts_url, :notice => 'Post successfully destroyed.'
  end
end
