class FavoriteBook < ApplicationRecord
  enum status: {normal: 0, favorite: 1}
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object, dependent: :destroy
  scope :user_book, ->(user_id, book_id){where(user_id: user_id).where(book_id: book_id)}
end
