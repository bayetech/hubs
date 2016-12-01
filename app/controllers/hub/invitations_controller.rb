module Hub
  class InvitationsController < ActionController::Base
    helper Hub::HubHelper
    layout 'invitation'
    before_action :set_current_customer

    def show
    end

    private

    def set_current_customer
      @current_customer = helpers.hub_current_customer
    end
  end
end
