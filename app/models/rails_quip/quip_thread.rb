module RailsQuip::QuipThread
  extend ActiveSupport::Concern

  included do
    attribute :type, :string
    attribute :title, :string
    attribute :html, :string
    
    belongs_to :quip_app
  end
  
end
