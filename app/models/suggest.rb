class Suggest < ApplicationRecord
  enum status: {sended: 0, approved: 1, rejected: 2}
  belongs_to :user
  validates :content, presence: true,
    length: {maximum: Settings.suggests.content.max_length}
end
