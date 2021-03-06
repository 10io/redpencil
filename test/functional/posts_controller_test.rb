require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get index" do
    session[:passwordless_uid] = users(:valid).id
    get :index
    
    assert_equal 2, assigns(:posts).size
    assert_response :success
  end

  test "should get show" do
    session[:passwordless_uid] = users(:valid).id
    get :show, :id => posts(:one).id
    
    assert_equal posts(:one), assigns(:post)
    assert_response :success
  end
  
  test "should get show wrong user" do
    session[:passwordless_uid] = users(:valid_token).id
    get :show, :id => posts(:one).id
    
    assert_response :redirect
    assert 'An error has occured.', flash[:alert]
  end

  test "should get new" do
    session[:passwordless_uid] = users(:valid).id
    get :new
    
    assert assigns(:post)
    assert_response :success
  end
  
  test "should not get new without uid" do
    get :new
    
    assert_response :redirect
    assert_equal "You must be logged in to access this page", flash[:alert]
  end
  
  test "should get new demo mode" do
    get :new, :demo => "1"
    
    assert assigns(:post)
    assert_response :success
  end

  test "should post create" do
    session[:passwordless_uid] = users(:valid).id
    assert_difference('Post.count') do
      post :create, :post => { :content => 'foobar' }
    end
    
    assert_redirected_to post_path(assigns(:post))
  end
  
  test "should not post create without uid" do
    post :create, :post => { :content => 'foobar' }
    
    assert_response :redirect
    assert_equal "You must be logged in to access this page", flash[:alert]
  end
  
  test "should post create demo mode" do
    assert_no_difference('Post.count') do
      post :create, :post => { :content => 'foobar' }, :demo => "1"
    end
    
    assert_template "demo" 
  end

  test "should get destroy" do
    session[:passwordless_uid] = users(:valid).id
    delete :destroy, :id => posts(:one).id
    
    begin
      Post.find(posts(:one).id)
      fail "should have thrown ActiveRecord::RecordNotFound"
    rescue ActiveRecord::RecordNotFound
      #normal behavior
    end
    
    assert_redirected_to posts_path
  end
  
  test "should get destroy wrong user" do
    session[:passwordless_uid] = users(:valid_token).id
    get :destroy, :id => posts(:one).id
    
    assert_response :redirect
    assert 'An error has occured.', flash[:alert]
  end

end
