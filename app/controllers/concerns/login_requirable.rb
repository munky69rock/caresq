# frozen_string_literal: true

module LoginRequirable
  extend ActiveSupport::Concern

  class Requirement
    def initialize(only: [], except: [])
      @mode = choose_mode(only, except)
      @actions = only.map(&:to_sym) if only?
      @actions = except.map(&:to_sym) if except?
    end

    def match?(action)
      all? ||
        (only? && @actions.include?(action.to_sym)) ||
        (except? && @actions.exclude?(action.to_sym))
    end

    private

    def choose_mode(only, except)
      if only.present?
        :only
      elsif except.present?
        :except
      else
        :all
      end
    end

    def only?
      @mode == :only
    end

    def except?
      @mode == :except
    end

    def all?
      @mode == :all
    end
  end

  module ClassMethods
    def require_login(only: [], except: [])
      @login_requirement = Requirement.new only: only, except: except
      before_action :assert_logged_in
    end
  end

  private

  def assert_logged_in
    return if user_signed_in?
    return unless self.class.instance_variable_get(:@login_requirement).match?(params[:action])
    session[:return_to] = request.fullpath if request.get?
    redirect_to new_user_session_url
  end
end
