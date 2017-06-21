# frozen_string_literal: true

class RootController < ApplicationController
  def index
    @post = Post.new if current_user.try(:confirmed?)
    @posts = Post.includes(:user, :tags).order(id: :desc).page params[:page]
    @likes = if current_user.try(:confirmed?)
               current_user.likes.where(post_id: @posts.map(&:id)).pluck(:post_id)
             else
               []
             end
  end
end
