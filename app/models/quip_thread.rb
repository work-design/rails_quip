class QuipThread < ApplicationRecord
  include RailsQuip::QuipThread
end unless defined? QuipThread
