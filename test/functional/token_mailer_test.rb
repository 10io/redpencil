require 'test_helper'

class TokenMailerTest < ActionMailer::TestCase
  test "Test send token" do
    u = users(:valid)
    t = u.generate_token
    
    email = TokenMailer.send_token(u, t).deliver
    assert !ActionMailer::Base.deliveries.empty?
    
    assert_equal [u.email], email.to
    assert_equal "Redpencil login link", email.subject
    assert_match(/We received a login request for #{u.email}/, email.encoded)
    assert_match(/http:\/\/dummy\/users\/check\?token=#{t.to_s}/, email.encoded)
  end
end
