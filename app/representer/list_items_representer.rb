class ListItemsRepresenter
  def initialize(list_items)
    @list_items = list_items
  end

  def as_json
    list_items.map do |list_item|
      {
        id: list_item.id,
        product_name: list_item.product.name,
        quantity: list_item.required_quantity
      }
    end
  end

  private

  attr_reader :list_items
end
