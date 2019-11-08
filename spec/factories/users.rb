FactoryBot.define do

  factory :takashi, class: User do
    name {"Takashi"}
    sequence(:email) { |n| "takashi#{n}@example.com" }
    password {"takashi"}
  end

  factory :satoshi, class: User do
    name {"Satoshi"}
    sequence(:email) { |n| "satoshi#{n}@example.com" }
    password {"satoshi"}
  end

end
