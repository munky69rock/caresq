require 'assets_manager'

if AssetsManager.aws_available?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: Settings.aws.region
    }
    config.fog_directory = Settings.aws.bucket
  end
end
