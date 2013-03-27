require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create valid user" do
    u = User.new({:email => 'foo2@bar.net'})
    
    assert u.valid?
    assert u.save
    
    assert !u.id.blank?
  end
  
  test "create invalid user empty name" do
    u = User.new()
    
    assert !u.valid?
    assert !u.save
    
    assert u.id.blank?
  end
  
  test "create invalid user invalid email" do
    u = User.new({:email => 'foo@foobar.'})
    
    assert !u.valid?
    assert !u.save
    
    assert u.id.blank?
  end
  
  test "create invalid user email already exists" do
    u = User.new({:email => 'foo@bar.net'})
    
    assert !u.valid?
    assert !u.save
    
    assert u.id.blank?
  end
  
  test "generates a new token" do
    c = users(:valid).generate_token
    
    assert users(:valid).token
    assert users(:valid).token_created_at
    assert !users(:valid).token_consumed
  end
  
  test "throw a code generation error" do
    begin
      users(:invalid).generate_token
      fail 'Expected to throw Exceptions::TokenGenerationError'
    rescue Exceptions::TokenGenerationError
      #nothing to do, expected behavior
    end
  end
  
  test "find by token" do
    u = User.find_by_token(users(:valid_token).token)
    
    assert_equal users(:valid_token), u
  end
  
  test "find by unknown token" do
    u = User.find_by_token('unknowntoken')
    
    assert u.nil?
  end
  
  test "find by already consumed token" do
    begin
      User.find_by_token(users(:already_consumed_token).token)
      fail 'Expected to throw Exceptions::TokenAlreadyConsumed'
    rescue Exceptions::TokenAlreadyConsumed
      #nothing to do, expected behavior
    end
  end
  
  test "find by expired token" do
    begin
      User.find_by_token(users(:expired_token).token)
      fail 'Expected to throw Exceptions::TokenExpired'
    rescue Exceptions::TokenExpired
      #nothing to do, expected behavior
    end
  end
  
end
