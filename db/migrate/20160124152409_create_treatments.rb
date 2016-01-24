class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.string :name, null: false
      t.integer :courses, default: 1
      t.integer :min_weeks
      t.boolean :reminders, default: true
      t.integer :min_spacing_weeks
      t.integer :max_spacing_weeks
      t.text :notes

      t.timestamps null: false
    end
  end
end
