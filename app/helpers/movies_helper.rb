module MoviesHelper
  def tab_class(tab)
    @page_tab == tab ? "active" : "nav-item"
  end

  def fetch_name(object)
  	object.map(&:name).join(", ")
  end
end
