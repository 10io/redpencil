class UsersController < ApplicationController
  
  def login
    if params[:email]
      u = User.find_by_email(params[:email])
    
      if u.nil?
        u = User.new(:email => params[:email])
      end
    
      begin
      token = u.generate_token
    
      TokenMailer.send_token(u, token).deliver
    
      flash[:notice] = "A login link has been sent to #{params[:email]}. Check your mailbox! (Don't forget to look in your spam folder)"
      
      rescue Exceptions::TokenGenerationError
        flash[:alert] = "Something wrong happened. Try to login again."
        flash[:alert] = u.errors.full_messages.first if u.invalid?
      end
    else
      flash[:alert] = "Something wrong happened. Try to login again."
    end
    redirect_to root_path
  end
  
  def check
    flash[:alert] = "Something wrong happened. Try to login again and we will send you a new link."
    if params[:token]
      begin
        u = User.find_by_token(params[:token])
        
        if !u.nil?
          reset_session
          session[:passwordless_uid] = u.id
          flash[:notice] = "Welcome back, #{u.email}"
          flash[:alert] = nil
          redirect_to posts_url
          return
        end
      rescue Exceptions::TokenAlreadyConsumed
        flash[:alert] = "Your login link has already been used. Try to login again and we will send you a new link."
      rescue Exceptions::TokenExpired
        flash[:alert] = "Your login link has expired. Try to login again and we will send you a new link."
      end
    end
    redirect_to root_path
  end

  def logout
    reset_session
    session[:passwordless_uid] = nil
    redirect_to root_path, :notice => "You have been logout successfully!"
  end
  
end
