module Quip
  class Post < ApplicationRecord
    include Detail::Model::Post
    include Model::Post
  end
end
