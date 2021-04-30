class SubcategoryRepresenter
  def initialize(subcategory)
    @subcategory = subcategory
  end

  def as_json
    {
      id: subcategory.id,
      name: subcategory.name,
      description: subcategory.description,
      category: subcategory.category.name
    }
  end

  private

  attr_reader :subcategory
end
