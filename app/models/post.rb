class Post < ActiveRecord::Base
  attr_accessible :content
  
  validates :content, :presence => true
  
  belongs_to :user
  
end
