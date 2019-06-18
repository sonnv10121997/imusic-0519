module LyricsHelper
  def lyric_approval_helper approved
    approved ? "btn btn-success" : "btn btn-danger"
  end

  def approved_lyric_percent
    Lyric.where(approved: true).pluck(:id).size / Lyric.pluck(:id).size.to_f * 100
  end
end
