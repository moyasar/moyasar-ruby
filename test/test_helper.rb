$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'moyasar'

require 'minitest/autorun'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

TEST_KEY = ENV.fetch('MOYASAR_TEST_SECRET_KEY')
EMPTY_ACCOUNT_TEST_KEY = ENV.fetch('MOYASAR_TEST_EMPTY_ACCOUNT_TEST_KEY')