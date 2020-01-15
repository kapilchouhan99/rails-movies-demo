class AddColumnsToMovies < ActiveRecord::Migration[5.2]
  def change
  	add_column :movies, :image, :string
  	add_column :movies, :genres, :string
  	add_column :movies, :stars, :text
  end
end
