class Post < ApplicationRecord
  include RailsDetail::Post
  include RailsQuip::Post
end unless defined? Post
