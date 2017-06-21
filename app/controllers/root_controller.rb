# frozen_string_literal: true

class RootController < ApplicationController
  def index
    @post = Post.new if current_user.try(:confirmed?)
    @posts = Post.includes(:user, :tags).order(id: :desc).page params[:page]
    @likes = current_user.likes.where(post_id: @posts.map(&:id)).pluck(:post_id)
  end
end
