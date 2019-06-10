module ApplicationHelper
  def rescue_title page_title = ""
    base_title = Settings.application.title
    page_title.empty? ? base_title : page_title << " | " << base_title
  end
end
