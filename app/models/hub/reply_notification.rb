module Hub
  class ReplyNotification < ActiveRecord::Base
    belongs_to :reply, foreign_key: :hubs_reply_id
    belongs_to :topic, foreign_key: :hubs_topic_id
    belongs_to :to_customer, class_name: Customer, counter_cache: true
    belongs_to :actor_customer, class_name: Customer
    validates :actor_customer_id, :to_customer_id, :hubs_reply_id, :hubs_topic_id, presence: true
  end
end
