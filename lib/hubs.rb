require 'hub/version'

module Hub
  class Engine < ::Rails::Engine
    engine_name 'hub'
    isolate_namespace Hub
  end

  if defined? Grape
    cf = File.dirname(__FILE__)

    autoload(:Liker, File.expand_path('../app/models/hubs/liker.rb', cf))
    autoload(:Notification, File.expand_path('../app/models/hubs/notification.rb', cf))
    autoload(:LikerNotification, File.expand_path('../app/models/hubs/liker_notification.rb', cf))
    autoload(:Relationship, File.expand_path('../app/models/hubs/relationship.rb', cf))
    autoload(:FollowerNotification, File.expand_path('../app/models/hubs/follower_notification.rb', cf))
    autoload(:Reply, File.expand_path('../app/models/hubs/reply.rb', cf))
    autoload(:ReplyNotification, File.expand_path('../app/models/hubs/reply_notification.rb', cf))
    autoload(:Topic, File.expand_path('../app/models/hubs/topic.rb', cf))
    autoload(:TopicImage, File.expand_path('../app/models/hubs/topic_image.rb', cf))
  end
end
