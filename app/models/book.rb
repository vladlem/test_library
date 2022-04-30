class Book < ApplicationRecord
  has_many :users, through: :user_books

  validates :name, presence: true, uniqueness: { scope: :author }
end
