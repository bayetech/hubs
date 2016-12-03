module Hub
  class Reply < ActiveRecord::Base
    establish_connection :bayehui
    include Hub::Uid
    include Hub::SoftDelete

    belongs_to :customer
    belongs_to :topic, foreign_key: :hubs_topic_id
    if Rails::VERSION::MAJOR >= 5
      belongs_to :reply_to_customer, class_name: Customer, optional: true
    else
      belongs_to :reply_to_customer, class_name: Customer
    end
    has_one :notification, class_name: ReplyNotification, foreign_key: :hubs_reply_id, dependent: :destroy
    has_one :reply_to_notification, class_name: ReplyNotification, foreign_key: :hubs_reply_id, dependent: :destroy

    validates :customer_id, :body, :hubs_topic_id, presence: true
    validate { errors.add(:body, '回复中有不允许发表的汉字或者表情。') unless body_content_valid? }

    before_create -> (r) { r.build_notification(to_customer: topic.customer, actor_customer: customer,
                                                topic: topic, title: topic.title, reply_body: body) }
    before_create -> (r) { r.build_reply_to_notification(to_customer: reply_to_customer, actor_customer: customer,
                                                         topic: topic, title: topic.title, reply_body: body) },
                  if: -> { reply_to_customer.present? }

    scope :recent, -> { order('id desc') }

    after_commit :update_topic_last_reply_at, on: [:create, :update]

    def update_topic_last_reply_at
      return if topic.blank?
      topic.replied_at = Time.current
      topic.last_active_mark = Time.now.to_i
      topic.replies_count = topic.replies.count
      topic.save
    end

    INVALID_CHARS = %w(                              ).freeze

    def body_content_valid?
      INVALID_CHARS.all? do |invalid_char|
        body.index(invalid_char).nil?
      end
    end

    def corrected_body_content
      INVALID_CHARS.each do |invalid_char|
        body.gsub!(invalid_char, '')
      end
      body
    end
  end
end
