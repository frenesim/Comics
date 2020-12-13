class ApplicationController < ActionController::Base
  before_action :set_cookie

  def set_cookie
    unless cookies[:current_user]
      cookies[:current_user] = { value: Time.current, expires: 30.minutes }
    end
  end
end
