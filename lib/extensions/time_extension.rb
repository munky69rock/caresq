# frozen_string_literal: true

module TimeExtension
  refine ActiveSupport::TimeWithZone do
    def years_from(time = Time.current)
      (strftime('%Y%m%d').to_i - time.strftime('%Y%m%d').to_i) / 10_000
    end
  end
end
