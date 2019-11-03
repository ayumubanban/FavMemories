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

  factory :other_user, class: User do
    # name {"hoge"}
    # email {"hoge@example.com"}
    sequence(:name) { |n| "OtherTestUser#{n}" }
    sequence(:email) { |n| "OtherTest#{n}@example.com" }
    password {"otherhogehoge"}

  end

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
