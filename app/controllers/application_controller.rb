class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :collection, :resource, :current_user

  before_action :authenticate!

  rescue_from AuthorizationError do
    head :unauthorized
  end

  def create
    render :errors unless resource.save
  end

  def destroy
    resource.destroy!

    head :ok
  end

  def current_user
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.joins(:auth_token).find_by(auth_tokens: { value: token })
    end
  end

  private
  def authenticate!
    current_user || raise(AuthorizationError)
  end
end
