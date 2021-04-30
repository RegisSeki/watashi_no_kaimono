class ProductsRepresenter
  def initialize(products)
    @products = products
  end

  def as_json
    products.map do |product|
      {
        id: product.id,
        name: product.name,
        category: product.subcategory.category.name,
        subcategory: product.subcategory.name
      }
    end
  end

  private

  attr_reader :products
end
