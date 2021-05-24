require 'rails_quip/engine'
require 'rails_quip/config'
require 'quip'

module Quip

  def self.use_relative_model_naming?
    true
  end

  def self.table_name_prefix
    'quip_'
  end

end
