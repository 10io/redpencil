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
  
  test "generates a new code" do
    c = users(:valid).generate_code
    
    assert users(:valid).hashed_code
    assert users(:valid).activated_at
    assert !users(:valid).activated
  end
  
  test "throw a code generation error" do
    begin
      users(:invalid).generate_code
      fail 'Expected to throw Exceptions::CodeGenerationError'
    rescue Exceptions::CodeGenerationError
      #nothing to do, expected behavior
    end
  end
  
  test "find by hashed code" do
    u = User.find_by_hashed_code(users(:valid_code).hashed_code)
    
    assert_equal users(:valid_code), u
  end
  
  test "find by unknown hashed code" do
    u = User.find_by_hashed_code('evilcode')
    
    assert u.nil?
  end
  
  test "find by already activated code" do
    begin
      User.find_by_hashed_code(users(:activated_code).hashed_code)
      fail 'Expected to throw Exceptions::CodeAlreadyActivated'
    rescue Exceptions::CodeAlreadyActivated
      #nothing to do, expected behavior
    end
  end
  
  test "find by expired code" do
    begin
      User.find_by_hashed_code(users(:expired_code).hashed_code)
      fail 'Expected to throw Exceptions::CodeExpired'
    rescue Exceptions::CodeExpired
      #nothing to do, expected behavior
    end
  end
  
end
