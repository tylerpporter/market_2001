class Item
  attr_reader :name, :price

  def initialize(params)
    @name = params[:name]
    @price = params[:price]
  end

  def convert_price
    @price.delete("$").to_f
  end

end
