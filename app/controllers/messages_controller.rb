class MessagesController < ApplicationController
  
  before_filter :who_called_message, :only => [:new, :create]
  
  def new
    @pid = params[:pid]
  end
  
  def create
    extra_id = "#{@instance.class.to_s.first}#{@instance.id}"
    uid = current_user.id
    pid = params[:pid].to_i
    conversation = Conversation.find(:all, :conditions => ["extra_id = ? AND ((user_id = ? AND participant_id = ?) OR (user_id = ? AND participant_id = ?))", extra_id, uid, pid, pid, uid])
    if !conversation.present?
      conversation = Conversation.create(
        :user_id => uid,
        :participant_id => pid,
        :extra_id => extra_id,
        :body => @instance.body
      )
    else
      conversation = conversation.first
    end
    message = Message.new(:user_id => current_user.id, :conversation_id => conversation.id, :body => params[:message][:body])
    if @instance.respond_to?("school")
      url = @instance.school
    else
      url = @instance.tweet.school
    end
    respond_to do |format|
      if message.save
        format.js
        format.html {redirect_to url}
      else
        format.js
        format.html {render :new}
      end
    end
  end
  
  def index
    @conversations = Conversation.find(:all, :conditions => ["user_id = ? OR participant_id = ?", current_user.id,current_user.id])
  end
  
  def chat
    @conversation = Conversation.find(params[:cid])
    @message = Message.new(:user_id => current_user.id, :conversation_id => @conversation.id, :body => params[:body])
    respond_to do |format|
      if @message.save
        format.js
        format.html {redirect_to messages_path}
      else
        format.js
        format.html {redirect_to messages_path}
      end
    end
  end
  
  protected
    def who_called_message
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return @instance = $1.classify.constantize.find(value)
        end
      end
    end
end
