FactoryBot.define do
  factory :book_suggestion do
    author { Faker::Name.first_name }
    title { Faker::Book.title }
    link { Faker::Internet.url }
    editor { Faker::Book.publisher } 
    year { Faker::Date.backward(100.years).year.to_s } 
    price { Faker::Number.between(1.0, 200.0) }  
    synopsis { Faker::Lorem.paragraph }
  end
end
