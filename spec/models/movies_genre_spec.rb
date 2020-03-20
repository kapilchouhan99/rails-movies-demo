require 'rails_helper'

RSpec.describe MoviesGenre, :type => :model do
  it "should belongs_to movie" do
    association = MoviesGenre.reflect_on_association(:movie)
    expect(association.macro).to eq(:belongs_to)
  end

  it "should belongs_to genre" do
    association = MoviesGenre.reflect_on_association(:genre)
    expect(association.macro).to eq(:belongs_to)
  end
end
