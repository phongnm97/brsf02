class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :stars, null: false, default: 0
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
    add_index :rates, [:user_id, :book_id]
  end
end
