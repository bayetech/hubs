module Hub
  module HubHelper
    def hub_deal_with_emoji(str)
      new_str = Gemojione.replace_unicode_moji_with_images(str).html_safe
      new_str.gsub(/\/(\d+)\//) { |s| x=s.gsub('/', ''); image_tag "face/#{x}.gif" }
    end

    def hub_time_ago_in_words(from_time)
      from_time > 1.week.ago ? time_ago_in_words(from_time) : from_time.strftime('%Y年%m月%d日')
    end

    def hub_avatar_tag(customer)
      raw_image_url = customer.avatar.try(:url)
      if raw_image_url.blank?
        wechat_user = customer.wechat_users.first
        raw_image_url = wechat_user.avatar.url if wechat_user.present?
      end
      raw_image_url = 'https://baye-media.oss-cn-shanghai.aliyuncs.com/default_head.png' if raw_image_url.blank?
      image_tag raw_image_url, onerror: 'hub_avatar_img_error(this);'
    end
  end
end
