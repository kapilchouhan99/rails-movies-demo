class Movie < ApplicationRecord
  acts_as_followable
  has_many :movies_genre
  has_many :genres, through: :movies_genre

  has_many :movies_star
  has_many :stars, through: :movies_star
end
