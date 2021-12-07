# 1. Create Config.local.json in Fastlane folder
# 2. Ask the user to enter...
    # 1. Apple ID
    # 2. Apple Password
# 3. Add the collected data to the config.local.json file

require 'json'
require 'fileutils'

# Make sure all project ruby dependencies are installed
begin
  require 'bundler'
  require 'fastlane'
  require 'cocoapods'
rescue LoadError
  `sudo gem install bundler`
  `bundle update`
end

system("ruby setup-fastlane.rb")

system("fastlane match development")
system("fastlane match adhoc")
system("fastlane match appstore")

puts "✅ All Done! ✅"
