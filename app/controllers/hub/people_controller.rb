module Hub
  class PeopleController < Hub::BaseController
    before_action :set_person

    def show
      if @person.uid == helpers.hub_current_customer.try(:uid)
        @title = '我的首页'
      else
        @title = "#{@person.name}的首页"
      end
      @topics = @person.topics
    end

    private

    def set_person
      @person = Customer.find_by(uid: params[:id])
    end
  end
end
