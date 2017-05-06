# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :verify_request_url

  private

  def verify_request_url
    url = ApplicationUrl.new(request)
    url.correct!
    redirect_to url.to_s, status: 301 if url.corrected?
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
