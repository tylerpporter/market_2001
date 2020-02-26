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

end
