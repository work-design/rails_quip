module RailsQuip::QuipApp
  extend ActiveSupport::Concern
  included do
    attribute :access_token, :string
    
    belongs_to :user, optional: true
  end

  # quip.com/dev/token get your access_token
  def api
    @api ||= Quip::Client.new(access_token: access_token)
  end

end
