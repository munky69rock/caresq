class CommentsController < ApplicationController
  include LoginRequirable
  require_login only: [:create]

  def create
    @comment = Comment.new comment_params
    @post = @comment.post
    if @comment.save
      redirect_to post_path(@comment.post_id)
    else
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :body)
  end
end