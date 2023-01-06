class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :brewery_name
      t.float :distance
      t.integer :calories
      t.integer :num_drinks
      t.string :drink_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
