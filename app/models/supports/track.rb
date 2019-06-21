class Supports::Track
  attr_reader :track, :params

  def initialize track, params
    @track = track
    @params = params
  end

  def build_comments
    comment = track.comments.build
  end

  def track_comments
    track.comments.latest.page(params[:page]).per Settings.comment.list
  end

  def latest_tracks
    Track.latest_with_limit Settings.track.list
  end
end
