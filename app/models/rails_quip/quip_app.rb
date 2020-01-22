module RailsQuip::QuipApp
  extend ActiveSupport::Concern
  included do
    attribute :access_token, :string
    attribute :private_folder_id, :string
    attribute :name, :string
    attribute :profile_picture_url, :string

    belongs_to :organ, optional: true
    belongs_to :user, optional: true
    has_many :post_syncs, as: :synced, dependent: :delete_all
    has_many :posts, through: :post_syncs

    after_create_commit :sync_info
  end

  # quip.com/dev/token get your access_token
  def api
    @api ||= Quip::Client.new(access_token: access_token)
  end

  def folders(type = 'private')
    r = api.get_folder cu["#{type}_folder_id"]
    Array(r.dig('children')).to_combine_h
  end

  def private_threads
    r = api.get_folder private_folder_id
    ids = Array(r.dig('children')).to_combine_h
    threads = api.get_threads Hash(ids)['thread_id']

    threads.each do |k, v|
      post_sync = post_syncs.find_or_initialize_by(source_id: k)
      if post_sync.post
        post = post_sync.post
      else
        post = posts.build
        post_sync.post = post
      end
      post.title = v.dig('thread', 'title')
      post.html = v['html']
      post.save
    end
  end

  def sync_info
    u = api.get_current_user
    self.name = u['name']
    self.private_folder_id = u['private_folder_id']
    self.profile_picture_url = u['profile_picture_url']
    self.save
  end

end
