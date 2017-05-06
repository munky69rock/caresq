# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :verify_domain

  private

  def verify_domain
    domain = request.domain
    return if Settings.domain.nil? || Settings.domain == domain
    url = URI.parse(request.original_url)
    url.host = Settings.domain
    redirect_to url.to_s, status: 301
  end

  def after_sign_in_path_for(_resource)
    blacklist = [new_user_session_path, new_user_registration_path]
    if (return_to = session.delete(:return_to))
      return_to
    elsif (return_to = session.delete(:user_return_to)) && !blacklist.include?(return_to)
      return_to
    else
      root_path
    end
  end
end
