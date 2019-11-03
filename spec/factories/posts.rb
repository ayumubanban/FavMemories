FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "TestPost#{n}" }
    association :user
    # ! これする前に、絶対アソシエーションをちゃんと定義し直した方がいい！！！
    # sequence(:user_id) { |n| n }
  end

  factory :apple, class: Post do
    content {"Apple"}
    # user_id {100}
  end

  factory :grape, class: Post do
    content {"Grape"}
    # user_id {100}
  end

  factory :invalid, class: Post do
    content {""}
    # user_id {100}
  end
end

