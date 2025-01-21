class ApplicationController < ActionController::API
#     config.middleware.use ActionDispatch::Cookies
#     config.middleware.use ActionDispatch::Session::CookieStore, key: '_your_app_session'
  attr_reader :current_user
  include ExceptionHandler

  private

  def authorize_request
    @current_user = AuthorizeUser.call(request.headers).result
    if @current_user.nil?  # Fix: Check for `@current_user` instead of `@user`
      render json: { error: 'Not Authorized', status: 401 }
    end
  end
end
