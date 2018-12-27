class BookStatus < ApplicationRecord
  enum status: {unread: 0, reading: 1, as_read: 2}
  has_one :activity, as: :object
  belongs_to :user
  belongs_to :book
end
