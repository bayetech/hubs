require 'carrierwave'
require 'hub/version'

module Hub
  class Engine < ::Rails::Engine
    engine_name 'hub'
    isolate_namespace Hub
  end

  if defined? Grape
    require_relative '../app/models/concerns/hub/soft_delete'
    require_relative '../app/models/concerns/hub/uid'
    require_relative '../app/models/concerns/hub/user_relation'

    require_relative '../app/uploaders/hub/base_uploader'
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
