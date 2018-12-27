class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  has_one :activity, as: :object
  default_scope ->{order created_at: :asc}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.comments.content.max_length}
  validates :acttivity_id, presence: true
end
