class Tweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :school, :counter_cache => true
  belongs_to :location
  
  has_many :comments, :dependent => :destroy
  
  default_scope :order => 'created_at DESC'
  
  validates_presence_of [:name, :hair, :body]
end
