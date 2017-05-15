# frozen_string_literal: true

class AssetsManager
  class << self
    def asset_host
      if aws_available?
        Settings.asset_host
      else
        ''
      end
    end

    def aws_available?
      %w[AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION].all? do |key|
        ENV[key].present?
      end
    end
  end
end
