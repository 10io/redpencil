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
  
  #GET /post/:id/edit -> html form for editing
  def edit
    @post = Post.find(params[:id])
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

  #PUT /post/:id -> update post
  def update
    @post = Post.find(params[:id])
    
    if @post.update_attributes(params[:post])
      redirect_to @post, :notice => 'Post successfully updated.'
    else
      render :action => 'edit', :alert => 'Post could not be updated.' 
    end
  end

  #DELETE /post/:id -> remove post
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    redirect_to posts_url, :notice => 'Post successfully destroyed.'
  end
end
