require 'rails_helper'

RSpec.describe MoviesStar, :type => :model do
  it "should belongs_to movie" do
    association = MoviesStar.reflect_on_association(:movie)
    expect(association.macro).to eq(:belongs_to)
  end

  it "should belongs_to genre" do
    association = MoviesStar.reflect_on_association(:star)
    expect(association.macro).to eq(:belongs_to)
  end
end
