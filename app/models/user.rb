class User < ActiveRecord::Base
  attr_accessible :email, :hashed_code, :activated, :activated_at
  
  validates :email, :presence => true, :uniqueness => true, :email => true
end
