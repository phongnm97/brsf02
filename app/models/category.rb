class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.categories.name.max_length}
end
