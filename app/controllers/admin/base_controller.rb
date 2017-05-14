# frozen_string_literal: true

module Admin
  class BaseController < ActionController::Base
    before_action :verify_role
    layout 'admin'

    private

    def verify_role
      # return if AdminUser.contains?(current_user)
      # redirect_to root_path
    end
  end
end
