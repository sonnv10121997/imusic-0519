module ArtistsHelper
  def artists_reference_collection
    Artist.pluck :name, :id
  end

  def limit_des_helper description
    return description if description.length < Settings.artist.description.limit
    description.first(Settings.artist.description.limit) << "..."
  end
end
