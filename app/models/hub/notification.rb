module Hub
  class Notification < ActiveRecord::Base
    if defined? $db_bayehui
      establish_connection $db_bayehui
    else
      establish_connection :bayehui
    end
    belongs_to :to_customer, class_name: Customer, counter_cache: true
    belongs_to :actor_customer, class_name: Customer
    validates :actor_customer_id, :to_customer_id, presence: true

    after_create { defined? EasemobHubsNotificationWorker && EasemobHubsNotificationWorker.perform_at(5.seconds.from_now, { from_customer_id: actor_customer_id, to_customer_id: to_customer.id } ) }
  end
end
