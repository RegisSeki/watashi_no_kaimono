class SubcategoriesRepresenter
  def initialize(subcategories)
    @subcategories = subcategories
  end

  def as_json
    subcategories.map do |subcategory|
      {
        id: subcategory.id,
        name: subcategory.name,
        description: subcategory.description,
        category: subcategory.category.name
      }
    end
  end

  private

  attr_reader :subcategories
end
