module Hub
  class TopicsController < Hub::BaseController
    def index
      @topics = Topic.page_includes.recent.show_in_recent.limit 20
    end
  end
end
