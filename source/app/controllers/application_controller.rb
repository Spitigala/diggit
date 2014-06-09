class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :vote_total
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end

  def logged_in?
    current_user != nil
  end

  def vote_total(voteable)
    voteable.votes.inject(0){ |sum, vote| sum += vote.value }
  end

  def prepare_vote_params(vote_params)
    prepared_params = vote_params
    prepared_params['user_id'] = vote_params['user_id'].to_i
    prepared_params['voteable_id'] = vote_params['voteable_id'].to_i
    prepared_params['value'] = vote_params['value'].to_i
    prepared_params
  end
end
