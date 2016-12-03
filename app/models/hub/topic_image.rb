module Hub
  class TopicImage < ActiveRecord::Base
    if defined? $db_bayehui
      establish_connection $db_bayehui
    else
      establish_connection :bayehui
    end
    belongs_to :topic, foreign_key: :hubs_topic_id, counter_cache: true

    mount_uploader :image, Hub::TopicImageUploader
  end
end
