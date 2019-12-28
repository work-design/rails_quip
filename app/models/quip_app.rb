class QuipApp < ApplicationRecord
  include RailsQuip::QuipApp
end unless defined? QuipApp
