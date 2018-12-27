class FavoriteBook < ApplicationRecord
  enum status: {normal: 0, favorite: 1}
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object
  validates :user_id, presence: true
  validates :book_id, presence: true
end
