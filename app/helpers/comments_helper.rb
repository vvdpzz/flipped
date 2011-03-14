module CommentsHelper
  def opt4c(obj)
    [timestamp(obj.created_at)].compact.join(delimitor).to_s.html_safe
  end
end
