class CreateJourneys < ActiveRecord::Migration[5.2]
  def change
    create_table :journeys do |t|
      t.string :from_loc
      t.string :to_loc
      t.integer :from_time
      t.integer :to_time
      t.string :from_date
      t.string :to_date
      t.float :price
      t.string :days
      t.integer :delay
      t.integer :user_id

      t.timestamps
    end
  end
end
