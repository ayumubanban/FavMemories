FactoryBot.define do
  factory :user do
    # name {"hoge"}
    # email {"hoge@example.com"}
    sequence(:name) { |n| "TestUser#{n}" }
    sequence(:email) { |n| "Test#{n}@example.com" }
    password {"hogehoge"}

    trait :invalid do
      name {nil}
    end
  end

  factory :takashi, class: User do
    name {"Takashi"}
    email {"takashi@example.com"}
    password {"takashi"}
  end

  factory :satoshi, class: User do
    name {"Satoshi"}
    email {"satoshi@example.com"}
    password {"satoshi"}
  end
end
