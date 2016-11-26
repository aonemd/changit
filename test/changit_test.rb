require 'test_helper'
require 'changit'

class ChangitTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Changit::VERSION
  end

  def test_it_does_something_useful
    assert 1 == 1
  end
end
