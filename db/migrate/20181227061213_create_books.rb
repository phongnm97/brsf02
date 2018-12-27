class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.text :title
      t.date :publish_date
      t.text :author
      t.integer :pages_count
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
