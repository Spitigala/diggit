class UsersController < ApplicationController
  # before_action :authenticate, except: [:show, :new]

  # def index
  # end

  def show
    @user = User.find(params[:id])
    @apple = "Apple"
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
    redirect_to root_path
  end

  def login
    #params should come from AJAX
  end

  def logout
    #params should come from AJAX
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :password_digest)
  end
end
