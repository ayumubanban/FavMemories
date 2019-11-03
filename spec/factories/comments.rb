FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "TestComment#{n}" }
    association :user
    association :post
  end

  factory :orange, class: Comment do
    content {"Orange"}
  end
end
