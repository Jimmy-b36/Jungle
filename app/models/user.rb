class User < ApplicationRecord
  has_secure_password

  before_validation :strip_whitespace, only: %i[email]

  validates_uniqueness_of :email, case_sensitive: false
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  protected

  # * this is it
  def self.authenticate_with_credentials(email, password)
    new_email = email.downcase
    user = User.find_by_email(new_email)
    user && user.authenticate(password) ? user : nil
  end

  def strip_whitespace
    self.email = self.email.strip unless self.email.nil?
  end
end
