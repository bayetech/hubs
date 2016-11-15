module Hub
  class TopicsController < Hub::BaseController
    helper Hub::HubHelper

    def index
      @topics = Topic.page_includes.recent.show_in_recent.limit 20
    end
  end
end
