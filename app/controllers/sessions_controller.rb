class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def destroy
    if current_user && current_user.sign_out
      render nothing: true, status: :ok
    else
      render json: current_user.errors.full_messages, status: :bad_request
    end
  end

  private
  def resource
    @session ||= Session.new resource_params
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end
end
