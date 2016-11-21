module Hub
  module HubHelper
    def hub_deal_with_emoji(str)
      new_str = Gemojione.replace_unicode_moji_with_images(str).html_safe
      new_str.gsub(%r{\/(\d+)\/}) { |s| x = s.delete('/', ''); image_tag "face/#{x}.gif" }
    end

    def hub_time_ago_in_words(from_time)
      from_time > 1.week.ago ? time_ago_in_words(from_time) : from_time.strftime('%Y年%m月%d日')
    end

    def hub_avatar_tag(customer, style_class: nil)
      raw_image_url = customer.avatar.try(:url)
      if raw_image_url.blank?
        wechat_user = customer.wechat_users.first
        raw_image_url = wechat_user.avatar.url if wechat_user.present?
      end
      raw_image_url = 'https://baye-media.oss-cn-shanghai.aliyuncs.com/default_head.png' if raw_image_url.blank?
      image_tag raw_image_url, onerror: 'hub_avatar_img_error(this);', class: style_class
    end

    def hub_current_customer
      session_customer = Customer.find_by(id: Rails.env.development? ? 901 : session[:customer_id])
      return session_customer if session_customer.present?

      app_client = Baye::CustomerClient.alive.find_by(session: request.headers['Authorization'].to_s)

      session[:customer_id] = app_client.try(:customer).try(:id)
      app_client.try(:customer)
    end
  end
end
