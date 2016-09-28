class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.string :image
      t.string :sex
      t.integer :curr_foster
      t.integer :contact
      t.integer :availability
      t.column :date_fostered, "timestamp with time zone"
      t.column :birthdate, "timestamp with time zone"
      t.column :date_adopted, "timestamp with time zone"
      t.integer :paper_location
      t.text :notes
      t.string :rescue_id

      t.timestamps null: false
    end
  end
end
