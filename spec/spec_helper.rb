require 'git_log_application'
require 'capybara'
require 'capybara/rspec'

Capybara.app = GitLogApplication

RSpec.configure do |config|
  config.include Capybara::DSL
end
