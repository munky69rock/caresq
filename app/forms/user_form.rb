# frozen_string_literal: true

require 'extensions/strong_parameters_extension'

class UserForm
  using StrongParametersExtension

  def initialize(user)
    @user = user
  end

  def attributes=(params)
    @user.attributes = params.except(:address)
    setup_address(params[:address]) if params[:address].present_values?
  end

  def validate
    @user.validate && validate_address
  end

  def save
    @user.save
    @address.try(:save)
  end

  def error_messages
    [
      @user.errors.full_messages,
      @address.try(:errors).try(:full_messages)
    ].flatten.join
  end

  private

  def setup_address(params)
    if @user.address.present?
      @user.address.attributes = params
    else
      @user.build_address params
    end
    @address = @user.address
  end

  def validate_address
    @address.nil? || @address.validate
  end
end
