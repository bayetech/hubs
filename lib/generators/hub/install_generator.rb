require 'rails/generators'
module Hub
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Create Hub's base files"
      source_root File.expand_path('../templates', __FILE__)

      def add_initializer
        path = "#{Rails.root}/config/initializers/hubs.rb"
        if File.exist?(path)
          puts 'Skipping config/initializers/hubs.rb creation, as file already exists!'
        else
          puts 'Adding Hubs initializer (config/initializers/hubs.rb)...'
          template 'config/initializers/hubs.rb', path
        end
      end

      def add_routes
        route 'mount Hub::Engine, at: "/hub"'
      end
    end
  end
end
