class ShoppingListsRepresenter
  def initialize(shopping_lists)
    @shopping_lists = shopping_lists
  end

  def as_json
    shopping_lists.map do |shopping_list|
      {
        id: shopping_list.id,
        name: shopping_list.name
      }
    end
  end

  private

  attr_reader :shopping_lists
end
