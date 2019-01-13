class BookFavorite < ApplicationRecord
  enum status: {normal: 0, favorite: 1}
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object
end
