# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.includes(comments: [:post]).find(params[:id])
  end
end
