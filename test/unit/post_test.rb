require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'create valid post' do
    p = Post.new({ content: 'foobar' })

    assert p.valid?
    assert p.save
    
    assert !p.id.blank?
  end
  
  test "can't create invalid post" do
    p = Post.new({ content: '    ' })
    
    assert !p.valid?
    assert !p.save
    
    assert p.id.blank?
  end
  
  test "find posts" do
    p = Post.find(posts(:one))
    
    assert_equal posts(:one), p
  end
end
