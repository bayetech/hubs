require 'hub/version'

module Hub
  class Engine < ::Rails::Engine
    engine_name 'hub'
    isolate_namespace Hub
  end
end
