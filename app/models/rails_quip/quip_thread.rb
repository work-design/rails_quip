module RailsQuip::QuipThread
  extend ActiveSupport::Concern

  included do
    attribute :type, :string
    attribute :source_id, :string
    attribute :title, :string
    attribute :html, :string
    
    belongs_to :quip_app
  end
  
  def content
    Quip::Thread::Document.new(html).to_html
  end
  
end
