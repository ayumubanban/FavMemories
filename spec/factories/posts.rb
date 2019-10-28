FactoryBot.define do
  factory :post do
    sequence(:content) { |n| "TestPost#{n}" }
    # ! これする前に、絶対アソシエーションをちゃんと定義し直した方がいい！！！
    # sequence(:user_id) { |n| n }
  end
end

