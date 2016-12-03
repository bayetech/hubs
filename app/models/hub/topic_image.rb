module Hub
  class TopicImage < ActiveRecord::Base
    establish_connection :bayehui
    belongs_to :topic, foreign_key: :hubs_topic_id, counter_cache: true

    mount_uploader :image, Hub::TopicImageUploader
  end
end
