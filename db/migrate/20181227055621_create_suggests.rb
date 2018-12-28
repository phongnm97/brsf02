class CreateSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true
      t.integer :status, null: false, default: 0
      t.text :content
      t.timestamps
    end
  end
end
