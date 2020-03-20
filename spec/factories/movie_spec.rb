FactoryBot.define do
  factory :movie do
    title { "movie name" }
    description { "movie description" }
    image { "https://m.media-amazon.com/images/M/MV5BZTAxNWE2MDItZWFlNS00MWM1LWI1ZjQtN2I5NDBhNWYzZjNhXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_UY98_CR0,0,67,98_AL_.jpg" }
    
    trait :movie_genres do
      after(:build) do |movie|
        movie.genres << FactoryBot.build(:genre)
      end
    end

    trait :movie_stars do
      after(:build) do |movie|
        movie.stars << FactoryBot.build(:star)
      end
    end
  end
end
