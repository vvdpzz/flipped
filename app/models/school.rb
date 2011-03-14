class School < ActiveRecord::Base
  belongs_to :province
  
  has_many :tweets, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  
  validates_presence_of [:name, :abbr], :on => :create, :message => "can't be blank"
  validates_uniqueness_of [:name, :abbr], :on => :create, :message => "must be unique"
  
  def to_param
    abbr
  end
end
