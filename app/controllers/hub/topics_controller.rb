module Hub
  class TopicsController < Hub::BaseController
    before_action :set_topic_title_current_customer, except: [:index]

    def index
      @current_customer = helpers.hub_current_customer
      @topics = Topic.page_includes.recent.limit 20
    end

    def show
      return redirect_to topics_path unless @topic.present?
      @replies = @topic.replies.includes(:customer)
      @reply = @replies.build
    end

    def reply
      @reply = @topic.replies.build(reply_params)
      @reply.customer_id = @current_customer.id
      if @reply.save
        flash[:notice] = '已回复成功。'
      else
        flash[:alert] = @reply.errors.full_messages.join('<br />')
      end
      respond_to do |format|
        format.html { redirect_to topic_path(id: @topic.uid) }
        format.js { render }
      end
    end

    def destroy
      if @topic.customer == @current_customer
        @topic.destroy
        redirect_to(topics_path, notice: '已删除成功。')
      else
        redirect_to(topics_path, notice: '您无法删除其他人的话题。')
      end
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

    def reply_params
      params.require(:reply).permit(:body, :reply_to_customer_id)
    end
  end
end
