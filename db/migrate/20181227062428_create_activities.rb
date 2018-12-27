class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :object, polymorphic: true, index: true

      t.timestamps
    end
  end
end
