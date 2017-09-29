require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'

Capybara.javascript_driver = :poltergeist

Capybara.register_driver(:poltergeist) do |app|
  Capybara::Poltergeist::Driver.new app, timeout: 90
end

RSpec.configure do |config|
  config.before :suite do
    Capybara.match = :prefer_exact
  end
end
