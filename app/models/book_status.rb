class BookStatus < ApplicationRecord
  after_save :create_activity
  enum status: {reading: 0, as_read: 1}
  scope :user_book, ->(user_id, book_id){where(user_id: user_id).where(book_id: book_id)}
  has_one :activity, as: :object, dependent: :destroy
  belongs_to :user
  belongs_to :book

  private

    def create_activity
      self.user.activities.build(object: self).save
    end
end
