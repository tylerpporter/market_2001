require_relative 'test_helper.rb'
require './lib/vendor.rb'
require './lib/item.rb'

class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_it_has_attributes
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_it_can_add_and_check_stock
    @vendor.stock(@item1, 30)
    assert_equal 30, @vendor.check_stock(@item1)
    @vendor.stock(@item2, 12)
    assert_equal ({@item1=>30, @item2=>12}), @vendor.inventory
  end

end
