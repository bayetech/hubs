module Hub
  class TopicsController < Hub::BaseController
    helper Hub::HubHelper
    before_action :set_topic_title_current_customer, except: [:index]

    def index
      customer = helpers.hub_current_customer
      if customer.present?
        @topics = customer.feed.limit 20
      else
        @topics = Topic.page_includes.recent.show_in_recent.limit 20
      end
      @refresh_heads_bar = false
    end

    def show
      return redirect_to hubs_topics_path unless @topic.present?
      @replies = @topic.replies.includes(:customer)
      @reply = @replies.build
      @refresh_heads_bar = true
    end

    def like
      @current_customer.like(@topic) unless @current_customer.liked?(@topic)
      render 'like_or_unlike'
    end

    def unlike
      @current_customer.unlike(@topic) if @current_customer.liked?(@topic)
      @topic.reload # seems a rails bug? must reload to make sure topic.likers_count correct
      render 'like_or_unlike'
    end

    private

    def set_topic_title_current_customer
      @current_customer = helpers.hub_current_customer
      @topic = Hub::Topic.find_by(uid: params[:id])
      return unless @topic.present?
      @title = @topic.title.truncate(21)
      @content_title = '巴圈 — 物以类聚，爷以群分'
    end
  end
end
