class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :hour_min, :to_ten

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    render file: '/public/401' unless current_user
  end

  def hour_min(runtime)
    hours = runtime / 60
    rest = runtime % 60
    "#{hours} hr #{rest} min"
  end

  def to_ten(array)
    array[0..9]
  end
end
