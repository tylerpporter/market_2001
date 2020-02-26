require_relative 'test_helper.rb'
require './lib/vendor.rb'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

end
