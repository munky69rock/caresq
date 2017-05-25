# frozen_string_literal: true

class RootController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.includes(:user, :tags).order(id: :desc).page params[:page]
  end
end
