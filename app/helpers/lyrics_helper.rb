module LyricsHelper
  def lyric_approval_helper approved
    approved ? "btn btn-success" : "btn btn-danger"
  end

  def approved_lyric_percent
    Lyric.where(approved: true).pluck(:id).size / Lyric.pluck(:id).size.to_f * 100
  end

  def contributor_helper approved_lyric
    return unless approved_lyric
    t "tracks.show.contributor", user: approved_lyric.user_name
  end

  def lyric_helper approved_lyric
    approved_lyric.content ||= content_tag :h5, t(".no_lyrics")
  end
end
