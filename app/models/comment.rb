class Comment < ApplicationRecord
  belongs_to :user
  has_one :activity, as: :object
  belongs_to :parent_activity, class_name: Activity.name,
    foreign_key: :parent_id
  validates :content, presence: true,
    length: {maximum: Settings.comments.content.max_length}
end
