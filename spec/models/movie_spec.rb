require 'rails_helper'

RSpec.describe Movie, :type => :model do
  let(:movie) { create(:movie) }

  it "has a valid factory" do
    expect(build(:movie)).to be_valid
  end

  it "should have many movies_genre" do
    association = Movie.reflect_on_association(:movies_genre)
    expect(association.macro).to eq(:has_many)
  end

  it "should have many genres" do
    association = Movie.reflect_on_association(:genres)
    expect(association.macro).to eq(:has_many)
  end

  it "should have many movies_star" do
    association = Movie.reflect_on_association(:movies_star)
    expect(association.macro).to eq(:has_many)
  end

  it "should have many stars" do
    association = Movie.reflect_on_association(:stars)
    expect(association.macro).to eq(:has_many)
  end

  context "when movie's genres created" do
    let(:genre) { create(:genre) }
    
    it "have created a movies_genre" do
      movie.genres << genre
      expect(MoviesGenre.first.movie).to eq(movie)
      expect(MoviesGenre.first.genre).to eq(genre)
    end
  end
 
  context "when movie's stars created" do
    let(:star) { create(:star) }
    
    it "have created a movies_genre" do
      movie.stars << star
      expect(MoviesStar.first.movie).to eq(movie)
      expect(MoviesStar.first.star).to eq(star)
    end
  end
end
