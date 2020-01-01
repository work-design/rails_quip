class Quip::Thread::Document < Quip::Thread
  attr_reader :raw_html, :html

  def initialize(html)
    @raw_html = html
    @html = Nokogiri::HTML.fragment(html)
  end
  
  def to_html
    clean_html(@html)
    @html.to_html
  end
  
  def clean_html(html)
    html.element_children.each do |h|
      h.remove_class
      h.remove_attribute 'id'
      h.remove_attribute 'style' if h['style'].blank?
      clean_html(h)
    end
  end

end
