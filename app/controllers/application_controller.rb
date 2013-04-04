class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?
  
  private
  
  def current_user
    @current_user ||= User.find_by_id(session[:passwordless_uid])
  end
    
  def logged_in?
    current_user != nil
  end
end
