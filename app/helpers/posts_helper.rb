module PostsHelper
  def own_post?(post)
    user_signed_in? && post.user.id == current_user.id
  end
end