module Hub
  class Relationship < ActiveRecord::Base
    if defined? $db_bayehui
      establish_connection $db_bayehui
    else
      establish_connection :bayehui
    end
    belongs_to :follower_customer, class_name: Customer
    belongs_to :followed_customer, class_name: Customer

    has_one :notification, class_name: FollowerNotification, foreign_key: :hubs_relationship_id, dependent: :destroy
    validates :follower_customer_id, :followed_customer_id, presence: true

    before_create -> (r) { r.build_notification(to_customer: followed_customer, actor_customer: follower_customer) }
  end
end
