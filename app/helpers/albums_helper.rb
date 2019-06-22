module AlbumsHelper
  def albums_reference_collection
    Album.pluck :name, :id
  end

  def join_categories_with_link categories, css_class = nil
    categories.map {|category| link_to category.name, category,
      class: css_class}.join ", "
  end

  def categories_name_join_helper categories
    categories.pluck(:name).join ", "
  end

  def hot_album_ids
    Album.where(hot: true).pluck :id
  end
end
