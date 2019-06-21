module CommentsHelper
  def can_manage_comment comment
    current_user == comment.user
  end
end
