require 'openssl'

class User < ApplicationRecord
  DIGEST = OpenSSL::Digest::SHA256.new
  ITERATIONS = 20_000
  USERNAME_FORMAT = /\A\w+\z/

  attr_accessor :password

  has_many :questions

  before_validation :downcase_username, on: :create
  before_save :encrypt_password

  validates :email, :username, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { minimum: 5, maximum: 40 }
  validates :username, format: { with: USERNAME_FORMAT }
  validates :password, on: :create, confirmation: true

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end
  
  def self.authenticate(email, password)
    user = find_by(email: email)
    return nil unless user.present?
    hashed_password = User.hash_to_string(
    OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    return user if user.password_hash == hashed_password
    nil
  end

  private
  
  def downcase_username
    self.username.downcase!
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end
end
