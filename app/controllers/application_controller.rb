class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
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
