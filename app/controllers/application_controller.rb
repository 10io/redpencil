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
  
  def require_login
    redirect_to root_path, :alert => 'You must be logged in to access this page' unless logged_in? or demo?
  end
  
  def demo?
    ["new", "create"].include?(params[:action]) and params[:demo] == "1"
  end
end
