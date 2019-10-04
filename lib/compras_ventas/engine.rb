module ComprasVentas
  class Engine < ::Rails::Engine
    # config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths << File.expand_path("../", __dir__)
  end
end
