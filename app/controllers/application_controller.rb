class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :get_current_time
  def get_current_time
  	return Time.now.strftime('%I:%M %p')
  end
end
