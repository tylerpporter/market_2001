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

  def total_quantity
    item_hash = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        item_hash[item] += quantity
      end
    end
    item_hash
  end

  # def total_inventory
  #   quantity_hash = {}
  #   item_hash = {}
  #   total_quantity.each do |item, quantity|
  #     quantity_hash[:quantity] = quantity
  #     item_hash[item] = quantity_hash
  #   end
  #   require "pry"; binding.pry
  # end

end
