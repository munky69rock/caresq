module LoginRequirable
  extend ActiveSupport::Concern

  class Requirement
    def initialize(only: [], except: [])
      @mode = if only.present?
                :only
              elsif except.present?
                :except
              else
                :all
              end
      if only?
        @actions = only.map(&:to_sym)
      elsif except?
        @actions = except.map(&:to_sym)
      end
    end

    def match?(action)
      all? || (only? && @actions.include?(action.to_sym)) || (except? && @actions.exclude?(action.to_sym))
    end

    private

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
      before_action :do_require_login
    end
  end

  private

  def do_require_login
    return if user_signed_in?
    if self.class.instance_variable_get(:@login_requirement).match?(params[:action])
      session[:return_to] = request.fullpath if request.get?
      redirect_to new_user_session_url
    end
  end
end