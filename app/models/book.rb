class Book < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :book_statuses, dependent: :destroy
  has_many :favorite_books, dependent: :destroy
  validates :title, presence: true,
    length: {maximum: Settings.books.title.max_length}
  validates :author, presence: true,
    length: {maximum: Settings.books.author.max_length}
  scope :title_contains, ->(title){where "title LIKE ?", "%#{title}%"}
  scope :author_contains, ->(author){where "author LIKE ?", "%#{author}%"}
  scope :category_id_is, ->(category_id){where "category_id LIKE ?", category_id}

  def self.search(term)
    results = self.where(nil)
    term.each do |key,value|
      results = results.send(key, value) if value.present?
    end
    results
  end
end
