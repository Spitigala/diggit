class UsersController < ApplicationController

  # def index
  # end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to root_path
  end

  # def edit
  # end

  # def update
  # end

  def destroy
    User.find(params[:id]).destroy
  end

  def login
    #NEED TO ADD CUSTOM ROUTE
  end

  def logout
    #NEED TO ADD CUSTOM ROUTE
  end
end
