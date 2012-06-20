class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :preview_password if Rails.env.production?

  private

    def preview_password
      authenticate_or_request_with_http_basic('Site under development') do |username, password|
        username == 'preview' && password == 'preview'
      end
    end
end
