class BookStatus < ApplicationRecord
  enum status: {reading: 0, as_read: 1}
  scope :user_book, ->(user_id, book_id){where(user_id: user_id).where(book_id: book_id)}
  has_one :activity, as: :object
  belongs_to :user
  belongs_to :book
end
