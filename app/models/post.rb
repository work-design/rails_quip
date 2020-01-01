class Post < ApplicationRecord
  include RailsQuip::Post
end unless defined? Post
