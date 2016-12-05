module Hub
  module RequestHelper
    def android_browser_request?
      ua = request.user_agent.downcase
      ua.match(/android/) && !ua.start_with?('dalvik')
    rescue
      false
    end

    def android_app_request?
      request.user_agent.downcase.start_with?('dalvik')
    rescue
      false
    end

    def iphone_browser_request?
      ua = request.user_agent.downcase
      ua.match(/iphone|ipad/) && !ua.start_with?('dalvik')
    rescue
      false
    end

    def iphone_ipad_app_request?
      request.user_agent.downcase.match(/iphone|ipad/)
    rescue
      false
    end
  end
end
