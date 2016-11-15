module Hub
  module HubHelper
    def hub_time_ago_in_words(from_time)
      from_time > 1.week.ago ? time_ago_in_words(from_time) : from_time.strftime('%Y年%m月%d日')
    end
  end
end
