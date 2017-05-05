# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.includes(posts: %i[tags], comments: [post: :user]).find(params[:id])
  end
end
