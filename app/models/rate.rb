class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object
  validates :stars, presence: true
end
