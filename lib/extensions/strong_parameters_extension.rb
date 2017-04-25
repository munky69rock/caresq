# frozen_string_literal: true

module StrongParametersExtension
  refine ActionController::Parameters do
    def blank_values?
      to_h.values.reject(&:blank?).blank?
    end

    def present_values?
      !blank_values?
    end
  end
end
