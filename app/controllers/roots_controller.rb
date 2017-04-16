class RootsController < ApplicationController
  def index
    @posts = Post.all
  end
end
