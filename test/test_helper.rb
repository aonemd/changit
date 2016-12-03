$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'

# some unorganized helpers

def assert_kind_of_array(kind, arr)
  arr.all? do |e|
    assert_kind_of kind, e
  end
end
