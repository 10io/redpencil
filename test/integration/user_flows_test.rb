require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "Browse list of posts and show one" do
    get "/posts"
    assert_response :success
    assert assigns(:posts)
    assert_select 'ul li', 2
    
    get "/posts/" + posts(:one).id.to_s
    assert_response :success
    assert_select 'pre', :count => 1, :text => 'MyText'
  end
end
