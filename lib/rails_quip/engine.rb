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

    initializer 'rails_quip.xx', before: :let_zeitwerk_take_over  do |app|
      if defined?(ENGINE_PATH) && ENGINE_PATH == (root + 'lib/rails_quip/engine').to_s
        _all_load_paths(app.config.add_autoload_paths_to_load_path).reverse_each do |path|
          $LOAD_PATH.unshift(path) if File.directory?(path)
        end
        $LOAD_PATH.uniq!

        ActiveSupport::Dependencies.autoload_paths = (_all_autoload_paths + ActiveSupport::Dependencies.autoload_paths).uniq
      end
    end

  end
end
