class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      !vendor.inventory[item].zero?
    end
  end

  def sorted_item_list
    all_items = []
    @vendors.each do |vendor|
      all_items << vendor.item_names
    end
    all_items.flatten.uniq.sort
  end

  def all_items
    @vendors.flat_map do |vendor|
      vendor.inventory.keys
    end.uniq
  end

  def total_quantity(item)
    @vendors.sum {|vendor| vendor.inventory[item]}
  end

  def vendors_by_item(item)
    @vendors.select {|vendor| !vendor.inventory[item].zero?}
  end

  def total_inventory
   all_items.reduce ({}) do |by_item, item|
     by_item[item] = {
       quantity: total_quantity(item),
       vendors: vendors_by_item(item)
     }
     by_item
   end
  end

  def overstocked_items
   total_inventory.select do |item, data|
     data[:quantity] > 50 && data[:vendors].size > 1
   end.keys
  end

end
