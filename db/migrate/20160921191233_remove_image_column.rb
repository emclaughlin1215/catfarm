class RemoveImageColumn < ActiveRecord::Migration
  def change
    remove_column :cats, :image, :string
  end
end
