module Hub
  class BaseController < ActionController::Base
    helper Hub::HubHelper
    layout 'hub_default'
  end
end
