require_relative 'test_helper.rb'
require './lib/item.rb'

class ItemTest < Minitest::Test

  def setup
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
  end

  def test_it_exists
    assert_instance_of Item, @item1
  end

  def test_is_has_attributes
    assert_equal 'Peach', @item1.name
    assert_equal "$0.75", @item1.price
  end

end
