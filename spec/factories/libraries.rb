FactoryBot.define do
  factory :library do
    name { "#{Faker::Address.street_name} Library" }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
  end
end
