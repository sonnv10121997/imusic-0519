module ApplicationHelper
  def rescue_title base_title, page_title = ""
    page_title.empty? ? base_title : page_title << " | " << base_title
  end
end
