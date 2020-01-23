class Quip::Thread::Document < Quip::Thread
  attr_reader :raw_html, :html

  def initialize(html)
    @raw_html = html
    @html = Nokogiri::HTML.fragment(html)
  end

  def to_html
    clean_html(@html)
    # Nokogiri Node SaveOptions without FORMAT
    @html.to_html save_with: 70
  end

  def clean_html(html)
    html.children.each do |h|
      if h.name == 'br' || (h.text? && h.blank?)
        h.remove
        next
      end
      h.remove_class
      h.remove_attribute 'id'
      h.remove_attribute 'style' if h['style'].blank?
      clean_html(h)
    end
  end

end
