require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    ActionMailer::Base.deliveries = []
  end
  
  test "should get login known user" do
    email_address = users(:valid).email
    get :login, :email => email_address
    
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
    get :login, :email => email_address
    
    assert_response :redirect
    assert_equal "A login link has been sent to #{email_address}. Check your mailbox! (Don't forget to look in your spam folder)", flash[:notice]
    assert !ActionMailer::Base.deliveries.empty?
    u = User.find_by_email(email_address)
    assert !u.token_consumed
    email = ActionMailer::Base.deliveries.first
    assert_equal "Redpencil login link", email.subject
    assert_equal [u.email], email.to
  end
  
  test "should get login without param" do
    get :login
    
    assert_response :redirect
    assert_equal "Something wrong happened. Try to login again.", flash[:alert]
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
