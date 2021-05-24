module Quip
  module Model::Post
    extend ActiveSupport::Concern

    included do
      attribute :html, :string
    end

    def content
      document.to_html
    end

    def document
      Quip::Thread::Document.new(html)
    end

  end
end
