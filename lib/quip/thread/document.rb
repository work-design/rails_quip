class Quip::Thread::Document < Quip::Thread
  attr_reader :raw_html, :html

  def initialize(html)
    @raw_html = html
    @html = Nokogiri::HTML.fragment(html)
  end
  
  def to_html
    @html.children.each do |html|
      html.remove_class
      html.remove_attribute 'id'
    end
    @html.to_html
  end

end
