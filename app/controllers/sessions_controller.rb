class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def destroy
    current_user.auth_token.destroy!
    
    head :ok
  end

  private
  def resource
    @session ||= Session.new resource_params
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end
end
