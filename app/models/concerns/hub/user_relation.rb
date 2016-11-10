module Hub
  module UserRelation
    extend ActiveSupport::Concern

    included do
      has_many :topics, -> { order(id: :desc) }, class_name: Topic
      has_many :active_relationships,  class_name:  Relationship,
                                       foreign_key: 'follower_customer_id',
                                       dependent:   :destroy
      has_many :passive_relationships, class_name:  Relationship,
                                       foreign_key: 'followed_customer_id',
                                       dependent:   :destroy

      has_many :following, through: :active_relationships,  source: :followed_customer
      has_many :followers, through: :passive_relationships, source: :follower_customer

      has_many :replies, class_name: HubsEngine::Reply, foreign_key: :customer_id
      has_many :reply_to_replies, class_name: HubsEngine::Reply, foreign_key: :reply_to_customer_id
      has_many :likers, class_name: HubsEngine::Liker, dependent: :destroy

      has_many :follower_notifications, class_name: HubsEngine::FollowerNotification, foreign_key: :to_customer_id
      has_many :liker_notifications, class_name: HubsEngine::LikerNotification, foreign_key: :to_customer_id
      has_many :notifications, class_name: HubsEngine::Notification, foreign_key: :to_customer_id
      has_many :reply_notifications, class_name: HubsEngine::ReplyNotification, foreign_key: :to_customer_id
    end

    def unread_notification_count
      liker_notifications_count + reply_notifications_count + follower_notifications_count + notifications_count
    end

    def feed
      HubsEngine::Topic.where(customer: self).or(HubsEngine::Topic.where(customer: following)).page_includes.recent
    end

    def follow(other_user)
      active_relationships.create(followed_customer_id: other_user.id)
    end

    def unfollow(other_user)
      active_relationships.find_by(followed_customer_id: other_user.id).destroy
    end

    def following?(other_user)
      active_relationships.find_by(followed_customer_id: other_user.id).present?
    end

    def my_replies
      replies.or(reply_to_replies)
    end

    def my_participant_topics
      HubsEngine::Topic.joins('left join hub_replies on hub_replies.hubs_topic_id = hub_topics.id')
                       .joins('left join hub_likers on hub_likers.hubs_topic_id = hub_topics.id')
                       .where('hub_replies.customer_id = ? or hub_likers.customer_id = ?', id, id)
                       .group('hub_topics.id')
    end

    def like(topic)
      topic.likers.create(customer_id: id)
    end

    def unlike(topic)
      topic.likers.find_by(customer_id: id).destroy
    end

    def liked?(topic)
      topic.likers.find_by(customer_id: id).present?
    end

    def replied?(topic)
      replies.find_by(topic: topic).present?
    end

    def can_publish_topic?
      # 1天之内发送的频率为10
      topic_count = topics.where('created_at > ? and created_at < ?', Time.current.beginning_of_day, Time.current.end_of_day).count
      return false if topic_count >= 10
      true
    end
  end
end
