require 'httpx'
require 'json'

module Quip
  class Client
    attr_reader :access_token, :client_id, :client_secret,
                :base_url, :request_timeout, :thread_id, :retry_method, :retry_attempts, :retry_count

    def initialize(options)
      @access_token = options.fetch(:access_token)
      @client_id = options.fetch(:client_id, nil)
      @client_secret = options.fetch(:client_secret, nil)
      @base_url = options.fetch(:base_url, 'https://platform.quip.com/1')
      @request_timeout = options.fetch(:request_timeout, 10)
      @retry_method = options[:retry_method] || :retry
      @retry_attempts = options[:retry_attempts] || 3
      @retry_count = 0
    end

    def get_current_user
      get 'users/current'
    end

    def get_folders
      get 'folders'
    end
    
    def get_folder(folder_id)
      get "folders/#{folder_id}"
    end

    def get_thread(thread_id)
      get "threads/#{thread_id}"
    end

    def get_threads(*thread_ids)
      get 'threads', ids: thread_ids.join(',')
    end

    def get_recent_threads(count = 20, max_usec = nil)
      get 'threads/recent', count: count, max_updated_usec: max_usec
    end

    def spreadsheet(thread_id)
      Quip::Spreadsheet.new(thread_id: thread_id, client: self)
    end

    def add_thread_members(thread_id, member_ids)
      post('threads/add-members', {
        thread_id: thread_id,
        member_ids: member_ids.join(',')
      })
    end

    def remove_thread_members(thread_id, member_ids)
      post('threads/remove-members', {
        thread_id: thread_id,
        member_ids: member_ids.join(',')
      })
    end

    def get_blob(thread_id, blob_id)
      get("blob/#{thread_id}/#{blob_id}")
    end

    def get_messages(thread_id)
      get("messages/#{thread_id}")
    end

    def post_message(thread_id, message)
      post('messages/new', {thread_id: thread_id, content: message})
    end

    def get_section(section_id, thread_id = nil)
      doc = parse_document_html(thread_id)
      element = doc.xpath(".//*[@id='#{section_id}']")
      element[0]
    end

    def get(path, params = {})
      handle_json_with_retry_method do
        response = HTTPX.plugin(:authentication).authentication("Bearer #{access_token}").get "#{base_url}/#{path}", params: params
        JSON.parse(response.body)
      end
    end

    def post(path, data)
      handle_json_with_retry_method do
        response = HTTPX.plugin(:authentication).authentication("Bearer #{access_token}").post "#{base_url}/#{path}", data
        JSON.parse(response.body)
      end
    end

    def handle_json_with_retry_method
      begin
        yield
      rescue Exception => e
        if @retry_method.to_sym == :retry && @retry_attempts > @retry_count
          @retry_count += 1
          sleep 0.5
          retry
        else
          raise e
        end
      end
    end
  end
end
