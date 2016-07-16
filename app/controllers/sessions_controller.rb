class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  before_action :session_service, except: :create

  def destroy
    if @session_service.sign_out
      head :ok
    else
      head :not_acceptable
    end
  end

  private
  def resource
    @session ||= Session.new resource_params
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end

  def session_service
    raise "Current user is nil" unless current_user

    @session_service ||= Session.new email: current_user.email
  end
end
