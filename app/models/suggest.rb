class Suggest < ApplicationRecord
  enum status: {sended: 0, approved: 1, rejected: 2}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.suggests.content.max_length}
end
