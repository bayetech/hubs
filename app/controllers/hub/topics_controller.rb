module Hub
  class TopicsController < Hub::BaseController
    def index
      @topics = Topic.page_includes.recent.show_in_recent
    end
  end
end
