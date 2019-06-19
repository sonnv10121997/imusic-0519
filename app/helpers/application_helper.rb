module ApplicationHelper
  def rescue_title base_title, page_title = ""
    page_title.empty? ? base_title : page_title << " | " << base_title
  end

  def rescue_image image, css_class
    return unless image.attached?
    content_tag :image, nil, src: url_for(image), class: css_class
  end
end
