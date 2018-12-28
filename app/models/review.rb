class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object
  validates :content, presence: true,
    length: {maximum: Settings.reviews.content.max_length}
  validates :title, presence: true,
    length: {maximum: Settings.reviews.title.max_length}
end
