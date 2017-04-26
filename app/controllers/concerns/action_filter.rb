# frozen_string_literal: true

class ActionFilter
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
