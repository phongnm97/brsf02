class Like < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  default_scope ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :acttivity_id, presence: true
end
