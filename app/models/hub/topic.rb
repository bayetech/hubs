module Hub
  class Topic < ActiveRecord::Base
    include Baye::Uid
    include Hub::SoftDelete

    belongs_to :customer
    has_many :images, foreign_key: :hubs_topic_id, class_name: Hub::TopicImage
    has_many :replies, foreign_key: :hubs_topic_id
    has_many :likers, foreign_key: :hubs_topic_id

    enum category: {
      '巴一下' => 0, '晒好物' => 1, '茶人茶事' => 3, '新品' => 4, '茶道' => 5
    }

    validates :customer_id, :title, presence: true

    accepts_nested_attributes_for :images, allow_destroy: true

    scope :recent, -> { order('id desc') }
    scope :show_in_recent, -> { where(show_in_recent: true) }
    scope :page_includes, -> { includes(:customer, :images) }

    before_create :set_last_active_mark
    def set_last_active_mark
      self.last_active_mark = Time.now.to_i
    end

    after_create :set_show_in_recent
    def set_show_in_recent
      Topic.where(customer: customer).update_all(show_in_recent: false)
      update_column('show_in_recent', true)
    end

    def activity_at
      replied_at || updated_at || created_at
    end
  end
end
