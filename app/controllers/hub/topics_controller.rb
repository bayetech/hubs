module Hub
  class TopicsController < Hub::BaseController
    helper Hub::HubHelper
    before_action :set_topic_and_title, only: [:show]

    def index
      @topics = Topic.page_includes.recent.show_in_recent.limit 20
    end

    def show
      return redirect_to hubs_topics_path unless @topic.present?
      @replies = @topic.replies.includes(:customer)
      @reply = @replies.build
    end

    private

    def set_topic_and_title
      @topic = Hub::Topic.find_by(uid: params[:id])
      return unless @topic.present?
      @title = @topic.title.truncate(21)
      @content_title = '巴圈 — 物以类聚，爷以群分'
    end
  end
end
