module AlbumsHelper
  def albums_reference_collection
    Album.pluck :name, :id
  end
end
