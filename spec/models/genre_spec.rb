require 'rails_helper'

RSpec.describe Genre, :type => :model do
  it "has a valid factory" do
    expect(build(:genre)).to be_valid
  end

  it "should have many movies_genre" do
    association = Genre.reflect_on_association(:movies_genre)
    expect(association.macro).to eq(:has_many)
  end

  it "should have many movies" do
    association = Genre.reflect_on_association(:movies)
    expect(association.macro).to eq(:has_many)
  end
end
