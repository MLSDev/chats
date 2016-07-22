class ProfilesController < ApplicationController
  skip_before_action :authenticate!, only: :create

  before_action :build_resource, only: :create

  def create
    respond_to do |format|
      format.html do
        if resource.save
          redirect_to profile_path(@user.id)
        else
          render :new
        end
      end

      format.js { render :errors unless resource.save }

      format.json { render :errors unless resource.save }
    end
  end

  private
  def build_resource
    @user = User.new resource_params
  end

  def resource
    @user ||= current_user
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
