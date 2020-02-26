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
      vendor.inventory.each do |item, v|
        all_items << item.name
      end
    end
    all_items.uniq.sort
  end

  def total_inventory
   items = @vendors.flat_map do |vendor|
     vendor.inventory.keys
   end.uniq
   items.reduce ({}) do |by_item, item|
     by_item[item] = {
       quantity: @vendors.sum {|vendor| vendor.inventory[item]},
       vendors: @vendors.select {|vendor| vendor.inventory.include?(item)}
     }
     by_item
   end
  end

  def overstocked_items
   items = total_inventory.select do |item, data|
     data[:quantity] > 50 && data[:vendors].size > 1
   end
   items.map {|item, data| item}
  end

end
