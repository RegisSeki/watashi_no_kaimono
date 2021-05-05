class ShoppingListRepresenter
  def initialize(shopping_list)
    @shopping_list = shopping_list
  end

  def as_json
    {
      id: shopping_list.id,
      name: shopping_list.name,
      owner: shopping_list.user.username
    }
  end

  private

  attr_reader :shopping_list
end
