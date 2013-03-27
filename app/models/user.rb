require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :email, :hashed_code, :activated, :activated_at
  
  validates :email, :presence => true, :uniqueness => true, :email => true
  
  def generate_code
    code = SecureRandom.hex(32).to_s
    self.hashed_code = BCrypt::Password.create(code)
    self.activated_at = Time.now
    self.activated = false

    return code if self.save
    raise Exceptions::CodeGenerationError
  end
  
  def self.find_by_hashed_code(hashed_code)
    u = User.where(:hashed_code => hashed_code).first
    return nil if u.nil?
    
    raise Exceptions::CodeAlreadyActivated if u.activated
    raise Exceptions::CodeExpired if Time.now - u.activated_at > PasswordlessConfig.config[:code_validity_period]
    
    # activates the code
    u.activated = true
    
    return u if u.save
  end
end
