require 'rails_helper'

RSpec.describe Star, :type => :model do
  it "has a valid factory" do
    expect(build(:star)).to be_valid
  end

  it "should have many movies_star" do
    association = Star.reflect_on_association(:movies_star)
    expect(association.macro).to eq(:has_many)
  end

  it "should have many movies" do
    association = Star.reflect_on_association(:movies)
    expect(association.macro).to eq(:has_many)
  end
end
