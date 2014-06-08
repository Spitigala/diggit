class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end

  def logged_in?
    current_user != nil
  end
end
