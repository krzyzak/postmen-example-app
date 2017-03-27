unless File.exists?('./credentials')
  puts "Couldn't find credentials file".red.bold
  puts "Please run `bundle exec postmen.rb setup` first".green.bold
  exit(1)
end

region, api_key = File.read('./credentials').split(',').map(&:chomp)


Postmen.configure do |config|
  config.region = region
  config.api_key = api_key
end
