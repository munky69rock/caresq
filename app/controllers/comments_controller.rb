# frozen_string_literal: true

class CommentsController < ApplicationController
  include LoginRequirable
  include RegistrationConfirmable

  require_login
  confirm_registration
  before_action :assert_commented_by_current_user, only: %i[edit update destroy]

  def create
    @comment_form = CommentForm.new comment_params
    if @comment_form.save
      redirect_to post_path(comment_params[:post_id])
    else
      render 'posts/show'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post.id)
    else
      render :edit
    end
  end

  def destroy
    post_id = @comment.post.id
    @comment.soft_destroy!
    redirect_to post_path(post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :user_id, :body)
  end

  def assert_commented_by_current_user
    @comment = Comment.find(params[:id])
    return if @comment.by? current_user
    raise ActionController::BadRequest,
          "Attempt to modify other user's comment: user:#{current_user.id},comment:#{@comment.id}"
  end
end
