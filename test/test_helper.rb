ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'minitest/autorun'
require 'rails/test_help'
require 'active_support/testing/assertions'

include ActiveSupport::Testing::Assertions

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
