class Api::RidersController < ApiController
  def current_timezone
    ActiveSupport::TimeZone['Pacific Time (US & Canada)']
  end
end