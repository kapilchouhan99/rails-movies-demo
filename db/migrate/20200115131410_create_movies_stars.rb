class CreateMoviesStars < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_stars do |t|
      t.references :movie, foreign_key: true
      t.references :star, foreign_key: true

      t.timestamps
    end
  end
end
