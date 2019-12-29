class Quip::Thread::Document < Quip::Thread
  attr_reader :html
  
  def initialize(html)
    @html = Nokogiri::HTML(html)
  end

end
