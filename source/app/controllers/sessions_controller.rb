class SessionsController < ApplicationController

  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:current_user_id] = user.id 
    end
  end

  def destroy
    @_current_user = session[:current_user_id] = nil
    redirect_to root_path
  end
end