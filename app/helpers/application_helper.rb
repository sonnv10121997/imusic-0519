module ApplicationHelper
  def rescue_title base_title, page_title = ""
    page_title.empty? ? base_title : page_title << " | " << base_title
  end

  def rescue_image image, css_class = nil
    return unless image.attached?
    content_tag :image, nil, src: url_for(image), class: css_class
  end

  def rescue_audio audio, css_class, id = nil
    return unless audio.attached?
    content_tag :audio, nil, src: url_for(audio), controls: true,
      preload: "auto", class: css_class, id: id
  end

  def rescue_user_avatar avatar, css_class = nil, fa_css_class = nil
    return fa_icon "user-circle-o #{fa_css_class}" unless avatar.attached?
    content_tag :image, nil, src: url_for(avatar), class: css_class
  end

  def hot_albums_tracks_size
    hot_album_ids.size + hot_track_ids.size
  end

  def favourited? favourite
    return false unless user_signed_in?
    current_user.favourites.include? favourite.favourite
  end
end
