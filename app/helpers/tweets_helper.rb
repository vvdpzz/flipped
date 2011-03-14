module TweetsHelper
  
  def comment(id)
    link_to('回复', new_tweet_comment_url(:tweet_id => id, :only_path => true), :remote => true)
  end
  
  def message4t(obj)
    link_to('私信', new_tweet_message_url(:tweet_id => obj.id, :pid => obj.user.id, :only_path => true), :remote => true)
  end
  
  def opt4t(obj)
    [comment(obj.id), message4t(obj), timestamp(obj.created_at)].compact.join(delimitor).to_s.html_safe
  end
  
end
