class TweetsController < ApplicationController
  
  before_filter :find_school
  
  def show
    @tweet = @school.tweets.find(params[:id], :include => [:location, :comments])
  end
  
  def create
    location = @school.locations.find_or_create_by_name(params[:location])
    @tweet = @school.tweets.build(params[:tweet])
    @tweet.location_id = location.id
    @tweet.user_id = current_user.id
    @tweet.name = Fruit.find(:all, :order => 'rand()', :limit => 1).first.name
    respond_to do |format|
      if @tweet.save
        format.js
        format.json {head :ok}
        format.html {redirect_to @school}
      else
        format.json {render :json => @tweet.errors, :status => :unprocessable_entity}
        format.html {redirect_to @school}
      end
    end
  end
  
  protected
    def find_school
      @school = School.find_by_abbr(params[:school_id])
    end
end
