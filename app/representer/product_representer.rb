class ProductRepresenter
  def initialize(product)
    @product = product
  end

  def as_json
    {
      id: product.id,
      name: product.name,
      category: product.subcategory.category.name,
      subcategory: product.subcategory.name,
      code: product.code,
      img_url: product.img_url
    }
  end

  private

  attr_reader :product
end
