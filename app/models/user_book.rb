class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :reservation_status, presence: true

  enum reservation_status: { reserved: 'reserved', returned: 'returned' }
end