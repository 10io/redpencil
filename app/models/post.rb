class Post < ActiveRecord::Base
  attr_accessible :content, :public
  
  validates :content, :presence => true
  
end
