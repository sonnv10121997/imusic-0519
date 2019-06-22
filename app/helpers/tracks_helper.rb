module TracksHelper
  def tracks_reference_collection
    Track.pluck :title, :id
  end

  def hot_track_ids
    Track.where(hot: true).pluck :id
  end
end
