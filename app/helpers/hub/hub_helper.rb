module Hub
  module HubHelper
    def hub_deal_with_emoji(str)
      new_str = Gemojione.replace_unicode_moji_with_images(str).html_safe
      new_str.gsub(%r{\/(\d+)\/}) { |s| image_tag "face/#{s}.gif" }
    end

    def hub_time_ago_in_words(from_time)
      from_time > 1.week.ago ? time_ago_in_words(from_time) : from_time.strftime('%Y年%m月%d日')
    end

    def hub_avatar_tag(customer, no_link: false, style_class: nil)
      raw_image_url = customer.avatar.try(:url, thumb: '@100w_1c')
      if raw_image_url.blank?
        wechat_user = customer.wechat_users.first
        raw_image_url = wechat_user.avatar.try(:url, thumb: '@100w_1c') if wechat_user.present?
      end
      raw_image_url = 'https://baye-media.oss-cn-shanghai.aliyuncs.com/default_head.png' if raw_image_url.blank?
      avatar_img = image_tag raw_image_url, onerror: 'hub_avatar_img_error(this);', class: style_class
      if no_link
        avatar_img
      else
        link_to avatar_img, person_path(id: customer.uid)
      end
    end

    def hub_current_customer
      session_customer = Customer.find_by(id: Rails.env.development? ? 901 : session[:customer_id])
      return session_customer if session_customer.present?

      app_client = Baye::CustomerClient.alive.find_by(session: request.headers['Authorization'].to_s)

      session[:customer_id] = app_client.try(:customer).try(:id)
      app_client.try(:customer)
    end

    def hub_liker_praise_link(current_user, topic, refresh_heads_bar: false)
      if current_user.blank?
        content_tag(:span) do
          concat(content_tag(:i, '', class: 'red-liker'))
          concat(topic.likers_count.zero? ? '赞' : topic.likers_count)
        end
      elsif current_user.liked? topic
        link_to unlike_topic_path(id: topic.uid, refresh_heads_bar: refresh_heads_bar), remote: true, method: :patch, class: "t_#{topic.uid}" do
          content_tag(:span) do
            concat(content_tag(:i, '', class: 'red-liker'))
            concat(topic.likers_count.zero? ? '赞' : topic.likers_count)
          end
        end
      else
        link_to like_topic_path(id: topic.uid, refresh_heads_bar: refresh_heads_bar), remote: true, method: :patch, class: "t_#{topic.uid}" do
          content_tag(:span) do
            concat(content_tag(:i, '', class: 'gray-liker'))
            concat(topic.likers_count.zero? ? '赞' : topic.likers_count)
          end
        end
      end
    end

    def hub_topic_likers_heads_bar(topic)
      content_tag(:div, class: 'topic-likers') do
        topic.likers.limit(9).each do |l|
          concat hub_avatar_tag(l.customer)
        end
      end
    end
  end
end
