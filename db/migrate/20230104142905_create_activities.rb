class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :brewery_name
      t.float :distance
      t.integer :calories
      t.integer :num_drinks
      t.string :drink_type
      t.float :dollars_saved
      t.float :lbs_carbon_saved
      t.bigint :strava_activity_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
