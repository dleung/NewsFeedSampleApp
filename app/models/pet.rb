class Pet < ActiveRecord::Base
  require 'obscenity/active_model'
  acts_as_news_feedable
  
  attr_accessible :name
  validates :name, presence: true
  validates :name, obscenity: true
  
  def news_feed_object_name
    name
  end
end
