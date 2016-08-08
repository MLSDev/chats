class UsersController < ApplicationController

  def index
    @users = User.pluck(:id, :name)
  end

end
