require 'carrierwave/orm/activerecord'

# See https://github.com/fog/fog/issues/3429 - uninitialized constant CarrierWave::Storage::Fog (NameError)
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# Don't attempt to upload to S3 for tests.
if ENV['CI'] || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else

  CarrierWave.configure do |config|
    config.storage         = :fog
    config.fog_provider    = 'fog/aws'                       # required
    config.fog_credentials = {
        provider:              'AWS',                        # required
        aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],     # required
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required
        region:                'ap-southeast-2',                  # optional, defaults to 'us-east-1'
        # host:                  's3.example.com',             # optional, defaults to nil
        # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    # Production is '2016-mapping-lighting' You can configure this in your .env file locally.
    config.fog_directory = ENV['AWS_S3_BUCKET_NAME']

    config.fog_public     = true                                        # optional, defaults to true
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
  end
end
