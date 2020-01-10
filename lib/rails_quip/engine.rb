require 'rails_com'
module RailsQuip
  class Engine < ::Rails::Engine

    config.generators do |g|
      g.rails = {
        assets: false,
        stylesheets: false,
        helper: false,
        system_tests: false,
        jbuilder: true
      }
      g.test_unit = {
        fixture: true,
        fixture_replacement: :factory_girl
      }
      g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

    config.after_initialize do |app|
      if defined?(ENGINE_PATH) && ENGINE_PATH == (root + 'lib/rails_quip/engine').to_s
        ActiveSupport::Dependencies.autoload_paths = (@instance.send(:_all_autoload_paths) + ActiveSupport::Dependencies.autoload_paths).uniq.freeze
      end
    end

  end
end
