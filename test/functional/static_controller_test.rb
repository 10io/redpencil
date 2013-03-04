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
  
  test "get about" do
    get :about
    
    assert_response :success
  end
  
  test "get credits" do
    get :credits
    
    assert_response :success
  end
end
