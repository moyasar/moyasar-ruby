$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'moyasar'

require 'date'

require 'minitest/autorun'
require 'minitest/reporters'
require 'webmock/minitest'

require 'server_stubs'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

TEST_KEY = ENV.fetch('MOYASAR_TEST_SECRET_KEY', 'sk_test_CG8kxfwbwqb39ffePB3UqUGa13k8WSeVLr3cNdjt')

# Disable all external request generally
WebMock.disable_net_connect!(allow_localhost: true)
