class TweetsController < ApplicationController
  def create
    @school = School.find_by_abbr(params[:school_id])
    location = @school.locations.find_or_create_by_name(params[:location])
    @tweet = @school.tweets.build(params[:tweet])
    @tweet.location_id = location.id
    @tweet.user_id = current_user.id
    respond_to do |format|
      if @tweet.save
        format.js
        format.json {head :ok}
      else
        format.json {render :json => @tweet.errors, :status => :unprocessable_entity}
      end
    end
  end
end
