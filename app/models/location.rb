class Location < ActiveRecord::Base
  belongs_to :school
  has_many :tweets
  validates_presence_of :name, :on => :create, :message => "can't be blank"
end
