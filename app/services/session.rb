class Session
  include ActiveModel::Validations

  delegate :auth_token, to: :user

  delegate :value, to: :auth_token, prefix: true

  def initialize params={}
    params = params&.symbolize_keys || {}

    @email = params[:email]

    @password = params[:password]
  end

  validate do |model|
    if user
      model.errors.add :password, 'is invalid' unless password?
    else
      model.errors.add :email, 'not found'
    end
  end

  def save
    return false unless valid?

    user.create_auth_token && true
  end

  def destroy!
    user.auth_token.destroy!
  end

  def as_json *args
    { auth_token: auth_token_value }
  end

  private
  def user
    @user ||= User.find_by email: @email
  end

  def password?
    user.authenticate @password
  end
end
