ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'factory_girl'
require 'rspec/rails'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
