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
      app.config.assets.precompile += %w(
        hubs/hub.js
        hubs/default.css
        hubs/default-large.css
        hubs/default-oppo.css
        hubs/emotion.png
        face/iconfont.png
        face/1.gif
        face/2.gif
        face/3.gif
        face/4.gif
        face/5.gif
        face/6.gif
        face/7.gif
        face/8.gif
        face/9.gif
        face/10.gif
        face/11.gif
        face/12.gif
        face/13.gif
        face/14.gif
        face/15.gif
        face/16.gif
        face/17.gif
        face/18.gif
        face/19.gif
        face/20.gif
        face/21.gif
        face/22.gif
        face/23.gif
        face/24.gif
        face/25.gif
        face/26.gif
        face/27.gif
        face/28.gif
        face/29.gif
        face/30.gif
        face/31.gif
        face/32.gif
        face/33.gif
        face/34.gif
        face/35.gif
        face/36.gif
        face/37.gif
        face/38.gif
        face/39.gif
        face/40.gif
        face/41.gif
        face/42.gif
        face/43.gif
        face/44.gif
        face/45.gif
        face/46.gif
        face/47.gif
        face/48.gif
        face/49.gif
        face/50.gif
        face/51.gif
        face/52.gif
        face/53.gif
        face/54.gif
        face/55.gif
        face/56.gif
        face/57.gif
        face/58.gif
        face/59.gif
        face/60.gif
        face/61.gif
        face/62.gif
        face/63.gif
        face/64.gif
        face/65.gif
        face/66.gif
        face/67.gif
        face/68.gif
        face/69.gif
        face/70.gif
        face/71.gif
        face/72.gif
        face/73.gif
        face/74.gif
        face/75.gif
      )
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
