class Star < ApplicationRecord
  acts_as_followable
  has_many :movies_star
  has_many :movies, through: :movies_star
end
