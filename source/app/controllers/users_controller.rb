class UsersController < ApplicationController
  # before_action :authenticate, except: [:show, :new]

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

  def destroy
    User.find(params[:id]).destroy
    # current_user.destroy if logged_in?  # => need to figure out how to test this. possibly 'post :login, id: <some_id>' before doing destroy test?
    redirect_to root_path
  end

  def signin
    if user = User.authenticate(params[:username], params[:password])
      session[:current_user_id] = user.id
    end
    redirect_to root_path
  end

  def signout
    @_current_user = session[:current_user_id] = nil
    redirect_to root_path    
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :password_digest)
  end
end
