require 'carrierwave'
unless defined? Grape
  require 'autoprefixer-rails'
  require 'normalize-scss'
  require 'turbolinks'
  require 'jquery-rails'
  require 'gemojione'
end
require 'hub/version'

module Hub
  class Engine < ::Rails::Engine
    engine_name 'hub'
    isolate_namespace Hub

    # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
    initializer 'hubs.assets.precompile', group: :all do |app|
      app.config.assets.precompile += %w(hubs/hub.js hubs/default.css)
    end
  end

  if defined? Grape
    require_relative '../app/models/concerns/hub/soft_delete'
    require_relative '../app/models/concerns/hub/uid'
    require_relative '../app/models/concerns/hub/user_relation'

    require_relative '../app/uploaders/hub/topic_image_uploader'

    cf = File.dirname(__FILE__)

    autoload(:Liker, File.expand_path('../app/models/hub/liker.rb', cf))
    autoload(:Notification, File.expand_path('../app/models/hub/notification.rb', cf))
    autoload(:LikerNotification, File.expand_path('../app/models/hub/liker_notification.rb', cf))
    autoload(:Relationship, File.expand_path('../app/models/hub/relationship.rb', cf))
    autoload(:FollowerNotification, File.expand_path('../app/models/hub/follower_notification.rb', cf))
    autoload(:Reply, File.expand_path('../app/models/hub/reply.rb', cf))
    autoload(:ReplyNotification, File.expand_path('../app/models/hub/reply_notification.rb', cf))
    autoload(:Topic, File.expand_path('../app/models/hub/topic.rb', cf))
    autoload(:TopicImage, File.expand_path('../app/models/hub/topic_image.rb', cf))
  end
end
