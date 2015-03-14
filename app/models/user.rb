# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_digest, :session_token
  validates_uniqueness_of :username, :email, :session_token
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :subs,
    foreign_key: :moderator_id,
    class_name: :Sub,
    inverse_of: :moderator
  )

  has_many(
    :posts,
    foreign_key: :author_id,
    class_name: :Post,
    inverse_of: :author
  )

  has_many(
    :comments,
    class_name: :Comment,
    foreign_key: :author_id
  )

  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    return unless user = User.find_by_username(username)
    user if user.is_password?(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token || get_new_session_token
  end

  def get_new_session_token
    begin
      token = SecureRandom.urlsafe_base64(16)
    end until User.find_by_session_token(token).nil?
    self.session_token = token
  end
end
