class User < ApplicationRecord
  has_secure_password

  has_many :books, through: :user_books

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  validates :user_type, presence: true

  enum user_type: { admin: 'admin', client: 'client' }

  def is_admin?
    user_type == 'admin'
  end
end
