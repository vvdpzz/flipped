module TweetsHelper
  
  def comment(id)
    link_to('回复', new_tweet_comment_url(:tweet_id => id), :remote => true)
  end
  
  def opt4t(obj)
    [comment(obj.id), timestamp(obj.created_at)].compact.join(delimitor).to_s.html_safe
  end
  
end
