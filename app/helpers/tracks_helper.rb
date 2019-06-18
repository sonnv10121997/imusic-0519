module TracksHelper
  def tracks_reference_collection
    Track.pluck :title, :id
  end
end
