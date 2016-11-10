require 'hubs/version'

module Hubs
  class Engine < ::Rails::Engine
    engine_name 'hubs'
    isolate_namespace Hubs
  end
end
