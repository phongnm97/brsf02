class Book < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :book_statuses, dependent: :destroy
  has_many :favorite_books, dependent: :destroy
  validates :category_id, presence: true
  validates :title, presence: true,
    length: {maximum: Settings.books.title.max_length}
  validates :author, presence: true,
    length: {maximum: Settings.books.author.max_length}
end
