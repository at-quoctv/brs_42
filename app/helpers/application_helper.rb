module ApplicationHelper
  def full_title page_title
    base_title = t "home.book"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  def index_for counter, page, per_page
    (page - 1) * per_page + counter + 1
  end
end
