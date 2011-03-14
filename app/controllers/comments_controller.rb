class CommentsController < ApplicationController
  before_filter :find_tweet
  
  def new    
  end
  
  def create
    
    history = current_user.comments.find_by_tweet_id(@tweet.id, :select => "tweet_id, name")
    if history.present?
      name = history.name
    else
      name = Fruit.find(:all, :order => 'random()', :limit => 1).first.name
    end
      
    @comment = current_user.comments.build(params[:comment])
    @comment.tweet_id = @tweet.id
    @comment.name = name
    respond_to do |format|
      if @comment.save
        format.js
        format.json {head :ok}
      else
        format.json {render :json => @comment.errors, :status => :unprocessable_entity}
      end
    end
  end
  
  protected
    def find_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
end
