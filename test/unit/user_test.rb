require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create valid user" do
    u = User.new({:email => 'foo@bar.net', })
    
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
end
