class CategoryRepresenter
  def initialize(category)
    @category = category
  end

  def as_json
    {
      id: category.id,
      name: category.name,
      description: category.description
    }
  end

  private

  attr_reader :category
end
