# frozen_string_literal: true

class RootsController < ApplicationController
  def index
    @posts = Post.includes(:user).page params[:page]
  end
end
