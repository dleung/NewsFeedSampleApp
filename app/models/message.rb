class Message < ActiveRecord::Base
  acts_as_news_feedable
  
  attr_accessible :name
  validates :name, presence: true

  def news_feed_object_name
    name
  end
end
