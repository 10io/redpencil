require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries = []
  end
  
  test "Browse list of posts and show one" do
    login(:valid)
    get "/posts"
    assert_response :success
    assert assigns(:posts)
    assert_select 'table.table tbody tr', 2
    
    get "/posts/" + posts(:one).id.to_s
    assert_response :success
    assert_select 'pre', :count => 1, :text => 'MyText'
  end
  
  test "Browse index, then the posts lists and create a new one" do
    login(:valid)
    get "/"
    assert_response :success
    assert_select 'h1', :text => 'Freewriting'
    
    get "/posts"
    assert_response :success
    assert assigns(:posts)
    assert_select 'table.table tbody tr', 2
    
    get "/posts/new"
    assert_response :success
    assert assigns(:post)
    assert_select 'h2', :text => 'New Post'
  end
  
  private
  
  def login(user)
    u = users(user)
    post "/users/login", :email => u.email
    assert_response :redirect
    token = ActionMailer::Base.deliveries.first.encoded.match(/token=(\w*)/)[1]
    
    get "/users/check", :token => token
    assert_response :redirect

  end
end
