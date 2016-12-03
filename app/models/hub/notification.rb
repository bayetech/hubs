module Hub
  class Notification < ActiveRecord::Base
    establish_connection :bayehui
    belongs_to :to_customer, class_name: Customer, counter_cache: true
    belongs_to :actor_customer, class_name: Customer
    validates :actor_customer_id, :to_customer_id, presence: true
  end
end
