class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  private
  def resource
    @session ||= Session.new resource_params
  end

  def resource_params
    if params[:session]
      params.require(:session).permit(:email, :password)
    else
      current_user.attributes
    end
  end
end
