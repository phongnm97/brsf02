class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object
  default_scope ->{order created_at: :asc}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.reviews.content.max_length}
  validates :book_id, presence: true
  validates :title, presence: true,
    length: {maximum: Settings.reviews.title.max_length}
end
