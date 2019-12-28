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
  
  def folders(type = 'private')
    cu = api.get_current_user
    r = api.get_folder cu["#{type}_folder_id"]
    Array(r.dig('children')).to_combine_h
  end
  
  def private_threads
    ids = folders['thread_id']
    api.get_threads Array(ids)
  end

end
