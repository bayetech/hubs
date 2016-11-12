module Hub
  class Liker < ActiveRecord::Base
    include Hub::Uid
    belongs_to :customer
    belongs_to :topic, foreign_key: :hubs_topic_id, counter_cache: true
    has_one :notification, class_name: LikerNotification, foreign_key: :hubs_liker_id, dependent: :destroy
    validates :customer_id, :hubs_topic_id, presence: true

    before_create -> (l) { l.build_notification(to_customer: topic.customer, actor_customer: customer, topic: topic, title: topic.title) }
  end
end
