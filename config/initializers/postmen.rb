region = Rails.application.secrets.region
api_key = Rails.application.secrets.api_key

raise "Please set api_key and region in config/secrerts.yml file" unless [rergion, api_key].all?

Postmen.configure do |config|
  config.region = region
  config.api_key = api_key
end
