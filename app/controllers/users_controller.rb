class UsersController < ApplicationController
  # your code goes here
  # /users -> GET
  def index
    @users = User.all
  end

  # /users/:id -> GET
  def show
    @user = User.find(params[:id])
    if @user
      render :show
    else
      # not found
      render :index, status: :not_found
    end
  end

  # /users/new -> GET
  def new
    @user = User.new
  end

  # /users -> POST
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      # with errors
      render :new, status: :unprocessable_entity
    end
  end

  # /users/:id/edit -> GET
  def edit
    if User.find(params[:id])
      @user = User.find(params[:id])
      render :edit
    else
      # not found
      render :index, status: :not_found
    end
  end

  # /users/:id -> PUT/PATCH
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # /users/:id -> DELETE
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :dob, :address)
  end
end
