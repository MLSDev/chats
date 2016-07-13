class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_one :auth_token, dependent: :destroy

  has_and_belongs_to_many :chats

  def sign_out
    auth_token.delete
  end
end
