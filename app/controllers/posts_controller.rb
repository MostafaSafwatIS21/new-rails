class PostsController < ApplicationController
  # your code goes here
  # /posts -> GET
  def index
    @posts = Post.all
  end

  # /posts/:id -> GET
  def show
    @post = Post.find(params[:id])
  end

  # /posts/new -> GET
  def new
    @post = Post.new
  end

  # /posts -> POST
  def create
    @post = Post.new(title: params[:post][:title], content: params[:post][:content])
    if @post.save
      redirect_to @post
    else
      # with errors
      render :new, status: :unprocessable_entity
    end
  end

  # /posts/:id/edit -> GET
  def edit
    @post = Post.find(params[:id])
  end

  # /posts/:id -> PUT/PATCH
  def update
    @post = Post.find(params[:id])
    if @post.update(title: params[:post][:title], content: params[:post][:content])
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # /posts/:id -> DELETE
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    else
      render :show, status: :unprocessable_entity
    end
  end
end
