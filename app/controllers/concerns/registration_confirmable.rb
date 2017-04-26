# frozen_string_literal: true

module RegistrationConfirmable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :confirmation_action_filter

    def confirm_registration(only: [], except: [])
      @confirmation_action_filter = ActionFilter.new only: only, except: except
      before_action :assert_registration_confirmed
    end
  end

  private

  def assert_registration_confirmed
    return unless self.class.confirmation_action_filter.match?(params[:action])
    return if current_user.try(:confirmed?)
    raise ActionController::BadRequest,
          "Invalid request to #{request.fullpath} by non-confirmed user: #{current_user.id}"
  end
end
