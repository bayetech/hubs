require 'hubs/version'

module HubsEngine
  class Engine < ::Rails::Engine
    engine_name 'hubs'
    isolate_namespace HubsEngine
  end
end
