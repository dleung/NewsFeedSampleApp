class User < ActiveRecord::Base
  # acts_as_news_feedable(object_name: first_)
  
  attr_accessible :first_name, :last_name
  # attr_accessor :object_name
  def self.full_name
    "#{first_name} #{last_name}"
  end
end
