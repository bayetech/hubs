module Hubs
  class TopicImage < ActiveRecord::Base
    self.table_name = 'hubs_topic_images'

    belongs_to :topic, foreign_key: :hubs_topic_id

    mount_uploader :image, HubsTopicImageUploader
  end
end
