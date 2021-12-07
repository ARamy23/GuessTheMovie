
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

# puts "Hello There!, Basically this is just a simple quick script to setup fastlane for a new project :)"
# puts "As of now, we are only using Fastlane, so we will be needing the following..."
# puts "1. AppleID"
# puts "2. Apple Password"
# puts "We will be using Fastlane's Credential Manager for this"
# puts "Please enter your Apple ID"
# apple_id = gets.chomp
# system("fastlane fastlane-credentials add --username #{apple_id}")

puts "Wonderful, now, what's your project name?"
project_name = gets.chomp

puts "Awesome, now, can I get your github's username? it should look like this (ARamy23/#{project_name})"
github_username = gets.chomp

# puts "Great!, now it's time to produce that app!"
# puts "Have you updated the Appfile, Fastfile, and Config.json, yet?"
# if gets.chomp == "yes"
#   puts "Great! Now it's time to produce that app!"
#   system("fastlane produce")
# else
#   puts "Please update the Appfile, Fastfile, and Config.json, we will start as soon as you return and type yes"
#   if gets.chomp == "yes"
#     puts "Great! Now it's time to produce that app!"
#     system("fastlane produce")
#   end
# end

puts "Now it's time to setup a github repo to store the certs and profiles"
puts "So let's do just that"

system("gh auth login")
system("gh repo create #{project_name}-Certs-Profiles --private --enable-issues=false --enable-wiki=false")

github_url_for_certs_repo = "https://github.com/#{github_username}/#{project_name}-Certs-Profiles"

json = JSON.parse(File.read('./fastlane/LocalConfig.json'))
json[:git_url] = github_url_for_certs_repo