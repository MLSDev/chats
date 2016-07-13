class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_one :auth_token, dependent: :destroy

  has_and_belongs_to_many :chats

  def sign_out
    errors.add :auth_token, "Failed to sign_out" unless auth_token.delete
  end
end
