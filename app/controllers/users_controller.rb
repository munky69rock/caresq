class UsersController < ApplicationController
  include LoginRequirable
  require_login only: [:index]

  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end
end