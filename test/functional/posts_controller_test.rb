require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    
    assert_equal 2, assigns(:posts).size
    assert_response :success
  end

  test "should get show" do
    get :show, :id => posts(:one).id
    
    assert_equal posts(:one), assigns(:post)
    assert_response :success
  end

  test "should get new" do
    get :new
    
    assert assigns(:post)
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => posts(:one).id
    
    assert_equal posts(:one), assigns(:post)
    assert_response :success
  end

  test "should post create" do
    assert_difference('Post.count') do
      post :create, :post => { :content => 'foobar', :public => false }
    end
    
    assert_redirected_to post_path(assigns(:post))
  end

  test "should get update" do
    put :update, :id => posts(:one).id, :post => { :content => 'foobar', :public => true }
    
    p = Post.find(posts(:one).id)
    assert_equal 'foobar', p.reload.content
    assert p.public
    assert_redirected_to post_path(assigns(:post))
  end

  test "should get destroy" do
    delete :destroy, :id => posts(:one).id
    
    begin
      Post.find(posts(:one).id)
      fail "should have thrown ActiveRecord::RecordNotFound"
    rescue ActiveRecord::RecordNotFound
      #normal behavior
    end
    
    assert_redirected_to posts_path
  end

end
