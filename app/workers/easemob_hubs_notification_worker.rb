class EasemobHubsNotificationWorker
  include Sidekiq::Worker

  def perform(params)
    to_customer = Customer.find(params[:to_customer_id])
    from_customer = Customer.find(params[:from_customer_id])

    ext_message = { liker_notifications_count: to_customer.liker_notifications_count,
                    reply_notifications_count: to_customer.reply_notifications_count,
                    follower_notifications_count: to_customer.follower_notifications_count,
                    notifications_count: to_customer.notifications_count
                  }

    res = Easemob.command_to(to_customer.uid, target_type: :users, action: :hubs_notification,
                   from: from_customer.uid, ext: ext_message)

    if res.all_success?
      to_customer.update(liker_notifications_count: 0,
                         reply_notifications_count: 0,
                         follower_notifications_count: 0,
                         notifications_count: 0
                        )
    end
  end
end
