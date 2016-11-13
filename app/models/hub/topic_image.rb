module Hub
  class TopicImage < ActiveRecord::Base
    belongs_to :topic, foreign_key: :hubs_topic_id

    mount_uploader :image, Hub::TopicImageUploader
  end
end
