module Hubs
  class FollowerNotification < ActiveRecord::Base
    self.table_name = 'hubs_follower_notifications'
    belongs_to :relationship, foreign_key: :hubs_relationship_id
    belongs_to :to_customer, class_name: Customer, counter_cache: true
    belongs_to :actor_customer, class_name: Customer
    validates :actor_customer_id, :to_customer_id, :hubs_relationship_id, presence: true
  end
end
