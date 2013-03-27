require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :email, :token, :token_consumed, :token_created_at
  
  validates :email, :presence => true, :uniqueness => true, :email => true
  
  def generate_token
    code = SecureRandom.hex(32).to_s
    self.token = BCrypt::Password.create(code)
    self.token_created_at = Time.now
    self.token_consumed = false

    return code if self.save
    raise Exceptions::TokenGenerationError
  end
  
  def self.find_by_token(token)
    u = User.where(:token => token).first
    return nil if u.nil?
    
    raise Exceptions::TokenAlreadyConsumed if u.token_consumed
    raise Exceptions::TokenExpired if Time.now - u.token_created_at > PasswordlessConfig.config[:token_validity_period]
    
    # consume the token
    u.token_consumed = true
    
    return u if u.save
  end
end
