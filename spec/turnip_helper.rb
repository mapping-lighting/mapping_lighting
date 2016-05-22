# Examples taken from https://github.com/jnicklas/turnip

require 'turnip/capybara'

# Forcing loading rails at this point to run the acceptance specs
require 'rails_helper'

# Load steps
Dir.glob("spec/steps/**/*steps.rb") { |f| load f, true }
require 'capybara/poltergeist'


Capybara.configure do |c|
  c.javascript_driver = :poltergeist
  # c.default_driver    = :poltergeist
end