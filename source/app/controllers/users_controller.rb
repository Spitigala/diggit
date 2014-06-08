class UsersController < ApplicationController
  # before_action :authenticate, except: [:show, :new]

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

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end

  def login
    #params should come from AJAX (connor?)
  end

  def logout
    #params should come from AJAX (connor?)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :password_digest)
  end
end
