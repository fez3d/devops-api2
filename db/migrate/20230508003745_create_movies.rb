class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :release
      t.string :publisher
      t.integer :rating
      t.string :genre

      t.timestamps
    end
  end
end
