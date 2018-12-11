FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    genre { Faker::Book.genre }
    author { Faker::Book.author }
    image { Faker::Avatar.image }
    editor { Faker::Book.publisher }
    year { Faker::Date.backward(100.years).year.to_s }
  end
end
