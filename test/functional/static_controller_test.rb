require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "get index" do
    get :index
    
    assert_response :success
  end
  
  test "get new_post" do
    get :new_post
    
    assert_response :success
  end
end
