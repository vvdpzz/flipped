class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me
  
  has_many :tweets
  has_many :comments
  has_many :conversations
  has_many :joined_conversations, :class_name => "Conversation", :foreign_key => "participant_id"
  has_many :messages
end
