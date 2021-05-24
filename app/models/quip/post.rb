module Quip
  class Post < ApplicationRecord
    self.table_name = 'detail_posts'

    include Detail::Model::Post
    include Model::Post
  end
end
