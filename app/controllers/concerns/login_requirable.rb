# frozen_string_literal: true

module LoginRequirable
  extend ActiveSupport::Concern

  module ClassMethods
    attr_reader :login_action_filter

    def require_login(only: [], except: [])
      @login_action_filter = ActionFilter.new only: only, except: except
      before_action :assert_logged_in
    end
  end

  private

  def assert_logged_in
    return unless self.class.login_action_filter.match?(params[:action])
    return if user_signed_in?
    session[:return_to] = request.fullpath if request.get?
    redirect_to new_user_session_url
  end
end
