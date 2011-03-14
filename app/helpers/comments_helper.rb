module CommentsHelper
  
  def message4c(obj)
    link_to('私信', new_comment_message_url(:comment_id => obj.id, :pid => obj.user.id, :only_path => true), :remote => true)
  end
  
  def opt4c(obj)
    [message4c(obj), timestamp(obj.created_at)].compact.join(delimitor).to_s.html_safe
  end
end
