class Genre < ApplicationRecord
  acts_as_followable
  has_many :movies_genre
  has_many :movies, through: :movies_genre
end
