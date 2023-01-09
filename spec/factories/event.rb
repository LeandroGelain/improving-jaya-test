FactoryBot.define do
  factory :event do
    issue_id { Faker::Number.unique.number(digits: 10) }
    action { Faker::Lorem.word }
    author { 
      { 
        id: Faker::Number.unique.number(digits: 10),
        login: Faker::Name.name
      } 
    }
  end
end
