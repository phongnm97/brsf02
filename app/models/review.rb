class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object
  validates :stars, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 5 }
  validates :title, presence: true,
    length: {maximum: Settings.reviews.title.max_length}
end
