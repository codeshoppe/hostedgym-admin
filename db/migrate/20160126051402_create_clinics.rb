class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :title
      t.string :description
      t.integer :spots_available
      t.decimal :price
      t.datetime :scheduled_for
      t.boolean :open_for_registration, default: false, null: false

      t.timestamps
    end
  end
end
