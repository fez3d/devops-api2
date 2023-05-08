FactoryBot.define do
  factory :book do
    name { Faker::Movie.title }
    release { Faker::Number.between(from: 1950, to: 2023) }
    publisher { Faker::Company.name }
    rating { Faker::Number.between(from: 50, to: 100) }
    genre { Faker::Movie.quote }
  end

  factory :movie do
    name { Faker::Movie.title }
    release { Faker::Number.between(from: 1950, to: 2023) }
    publisher { Faker::Company.name }
    rating { Faker::Number.between(from: 50, to: 100) }
    genre { Faker::Movie.quote }
  end
end