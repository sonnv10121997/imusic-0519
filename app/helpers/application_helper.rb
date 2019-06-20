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
end
