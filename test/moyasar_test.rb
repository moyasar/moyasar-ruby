require 'test_helper'

class MoyasarTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Moyasar::VERSION
  end

  def test_should_accept_api_key
    refute_nil Moyasar.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"
  end
end
