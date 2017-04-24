class UsersController < ApplicationController
  include LoginRequirable
  require_login only: [:index, :edit, :update]

  def index
    @user = current_user
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
    @address = current_user.address || Address.new(user_id: current_user.id)
  end

  def update
    @user = current_user
    update_address = user_params[:address].to_h.any? { |_, v| v.present? }
    @user.attributes = user_params.to_h.except(:address)
    if update_address
      if @user.address.present?
        @user.address.update(user_params[:address])
      else
        @user.build_address(user_params[:address])
      end
    end
    if @user.validate && (!update_address || @user.address.validate)
      @user.save
      @user.address.save if update_address
      redirect_to users_path
    else
      @error = @user.errors.full_messages.join(',') + @user.address.errors.full_messages.join(',')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :description,
      address: [:postal_code, :prefecture, :city]
    )
  end
end