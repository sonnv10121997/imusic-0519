module ArtistsHelper
  def artists_reference_collection
    Artist.pluck :name, :id
  end
end
