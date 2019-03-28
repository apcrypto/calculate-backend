class CreateJourneys < ActiveRecord::Migration[5.2]
  def change
    create_table :journeys do |t|
      t.string :arrival_loc
      t.string :date_of_service
      t.float :price
      t.float :refund
      t.integer :delay
      t.integer :user_id

      t.timestamps
    end
  end
end
