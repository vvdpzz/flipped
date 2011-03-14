class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet, :counter_cache => true
  validates_presence_of :body, :on => :create, :message => "can't be blank"
end
