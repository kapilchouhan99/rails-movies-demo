class MoviesStar < ApplicationRecord
  belongs_to :movie
  belongs_to :star
end
