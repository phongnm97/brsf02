class Book < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :book_statuses, dependent: :destroy
  has_many :favorite_books, dependent: :destroy
  validates :title, presence: true,
    length: {maximum: Settings.books.title.max_length}
  validates :author, presence: true,
    length: {maximum: Settings.books.author.max_length}
  validates :pages_count, presence: true,
    numericality: { only_integer: true, less_than_or_equal_to: 2000, more_than: 0 }
  scope :title_contains, ->(title){where "title LIKE ?", "%#{title}%"}
  scope :author_contains, ->(author){where "author LIKE ?", "%#{author}%"}
  scope :category_id_is, ->(category_id){where "category_id LIKE ?", category_id}

  # scope :join_status, (lambda do |id|
  # select("books.*, book_statuses.status as status, book_statuses.id as status_id ")
  # .joins("LEFT OUTER JOIN book_statuses ON book_statuses.book_id = books.id AND book_statuses.user_id = "+ "#{id}")
  # end)

  def self.search(term)
    results = self.where(nil)
    term.each do |key,value|
      results = results.send(key, value) if value.present?
    end
    results
  end
end
