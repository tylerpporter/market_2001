class Market
  attr_reader :name, :vendors, :date

  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select {|vendor| !vendor.inventory[item].zero?}
  end

  def all_items
    @vendors.flat_map {|vendor| vendor.inventory.keys}.uniq
  end

  def sorted_item_list
    all_items.map(&:name).sort
  end

  def total_quantity(item)
    @vendors.sum {|vendor| vendor.inventory[item]}
  end

  def total_inventory
   all_items.reduce ({}) do |by_item, item|
     by_item[item] = {
       quantity: total_quantity(item),
       vendors: vendors_that_sell(item)
     }
     by_item
   end
  end

  def overstocked_items
   total_inventory.select do |item, data|
     data[:quantity] > 50 && data[:vendors].size > 1
   end.keys
  end

  def sell(item, quantity)
    return false if quantity > total_inventory[item][:quantity]
    vendors_that_sell(item).each do |vendor|
      if vendor.inventory[item].zero?
        next
      elsif vendor.inventory[item] >= quantity
        vendor.inventory[item] -= quantity
        true
      elsif vendor.inventory[item] < quantity
        quantity = quantity - vendor.inventory[item]
        vendor.inventory[item] = 0
      end
    end
  end

end
