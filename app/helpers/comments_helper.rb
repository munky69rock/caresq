module CommentsHelper
  def own_comment?(comment)
    user_signed_in? && comment.user.id == current_user.id
  end
end