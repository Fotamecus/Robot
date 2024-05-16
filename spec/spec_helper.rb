require 'rspec'
Dir[File.expand_path('../../lib/**/*.rb', __FILE__)].each { |file| require file }

# Disable stdout for all tests
RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end
