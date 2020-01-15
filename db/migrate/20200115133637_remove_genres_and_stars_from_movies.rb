class RemoveGenresAndStarsFromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :genres, :string
    remove_column :movies, :stars, :text
  end
end
