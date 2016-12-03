module Hub
  class LikerNotification < ActiveRecord::Base
    if defined? $db_bayehui
      establish_connection $db_bayehui
    else
      establish_connection :bayehui
    end
    belongs_to :liker, foreign_key: :hubs_liker_id
    belongs_to :topic, foreign_key: :hubs_topic_id
    belongs_to :to_customer, class_name: Customer, counter_cache: true
    belongs_to :actor_customer, class_name: Customer
    validates :actor_customer_id, :to_customer_id, :hubs_liker_id, :hubs_topic_id, presence: true
  end
end
