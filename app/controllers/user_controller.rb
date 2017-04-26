# frozen_string_literal: true

class UserController < ApplicationController
  include LoginRequirable
  require_login only: %i[show edit update]

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = current_user
    @address = current_user.address || current_user.build_address
  end

  def update
    @form = UserForm.new(current_user)
    @form.attributes = user_params
    if @form.validate
      @form.save
      redirect_to user_index_path
    else
      @error = @form.error_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :description,
      :birth_date,
      :gender,
      address: %i[postal_code prefecture city]
    ).tap do |params|
      params[:gender] = params[:gender].to_i if params[:gender].present?
    end
  end
end
