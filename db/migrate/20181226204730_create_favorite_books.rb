class CreateFavoriteBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_books do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :favorite_books, [:user_id, :created_at]
    add_index :favorite_books, [:book_id, :created_at]
  end
end
