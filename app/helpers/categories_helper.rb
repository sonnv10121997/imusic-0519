module CategoriesHelper
  def categories_reference_collection
    Category.pluck :name, :id
  end
end
