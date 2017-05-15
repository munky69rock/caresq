# frozen_string_literal: true

require 'assets_manager'

class ImageUploader < CarrierWave::Uploader::Base
  storage AssetsManager.aws_available? ? :fog : :file
end
