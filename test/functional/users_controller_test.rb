require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    ActionMailer::Base.deliveries = []
  end
  
  test "should get login known user" do
    email_address = users(:valid).email
    post :login, :email => email_address
    
    assert_response :redirect
    assert_equal "A login link has been sent to #{email_address}. Check your mailbox! (Don't forget to look in your spam folder)", flash[:notice]
    assert !ActionMailer::Base.deliveries.empty?
    u = User.find_by_email(email_address)
    assert !u.token_consumed
    email = ActionMailer::Base.deliveries.first
    assert_equal "Redpencil login link", email.subject
    assert_equal [u.email], email.to
  end
  
  test "should get login unknown user" do
    email_address = "foobarish@sandbox.net"
    post :login, :email => email_address
    
    assert_response :redirect
    assert_equal "A login link has been sent to #{email_address}. Check your mailbox! (Don't forget to look in your spam folder)", flash[:notice]
    assert !ActionMailer::Base.deliveries.empty?
    u = User.find_by_email(email_address)
    assert !u.token_consumed
    email = ActionMailer::Base.deliveries.first
    assert_equal "Redpencil login link", email.subject
    assert_equal [u.email], email.to
  end
  
  test "should get login invalid email" do
    post :login, :email => "this_is_not_an_email_address"
    
    assert_response :redirect
    assert_equal "Email this_is_not_an_email_address is not a valid email address.", flash[:alert]
  end
  
  test "should get login without param" do
    post :login
    
    assert_response :redirect
    assert_equal "Something wrong happened. Try to login again.", flash[:alert]
  end
  
  test "should get check valid token" do
    get :check, :token => "validtoken"
    
    assert_response :redirect
    assert_equal "Welcome back, #{users(:valid_token).email}", flash[:notice]
    assert_equal nil, flash[:alert]
    assert !session[:passwordless_uid].nil?
  end
  
  test "should get check already consumed token" do
    get :check, :token => "alreadyconsumedtoken"
    
    assert_response :redirect
    assert_equal "Your login link has already been used. Try to login again and we will send you a new link.", flash[:alert]
    assert session[:passwordless_uid].nil?
  end
  
  test "should get check expired token" do
    get :check, :token => "expiredtoken"
    
    assert_response :redirect
    assert_equal "Your login link has expired. Try to login again and we will send you a new link.", flash[:alert]
    assert session[:passwordless_uid].nil?
  end
  
  test "should get check without param" do
    get :check
    
    assert_response :redirect
    assert_equal "Something wrong happened. Try to login again and we will send you a new link.", flash[:alert]
    assert session[:passwordless_uid].nil?
  end
  
  test "should get check unknown token" do
    get :check, :token => "unknown token"
    
    assert_response :redirect
    assert_equal "Something wrong happened. Try to login again and we will send you a new link.", flash[:alert]
    assert session[:passwordless_uid].nil?
  end

  test "should get logout" do
    get :logout
    assert_response :redirect
    assert_equal "You have been logout successfully!", flash[:notice]
  end
  
  test "should delete destroy without user" do
    delete :destroy
    
    assert_response :redirect
  end
  
  test "should delete destroy" do
    uid = users(:valid).id
    p1id = users(:valid).posts.first
    p2id = users(:valid).posts.second
    session[:passwordless_uid] = uid
    
    delete :destroy
    
    assert_response :redirect
    assert_equal "Your user and all your posts have been deleted!", flash[:alert]
    assert User.find_by_id(uid).nil?
    assert Post.find_by_id(p1id).nil?
    assert Post.find_by_id(p2id).nil?
  end
end
