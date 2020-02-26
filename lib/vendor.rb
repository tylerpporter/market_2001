class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def potential_item_revenue
    items = []
    @inventory.each do |item, quantity|
      items << item.convert_price * quantity
    end
    items
  end

  def potential_revenue
    potential_item_revenue.sum
  end

  def item_names
    @inventory.map {|item, v| item.name}
  end

end
