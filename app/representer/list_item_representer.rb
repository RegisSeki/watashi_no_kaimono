class ListItemRepresenter
  def initialize(list_item)
    @list_item = list_item
  end

  def as_json
    {

    }
  end

  private

  attr_reader :list_item
end
