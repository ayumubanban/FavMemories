FactoryBot.define do

  factory :post, class: Post do
    content {"Post"}
  end

  factory :other_post, class: Post do
    content {"OtherPost"}
  end

  factory :invalid, class: Post do
    content {""}
  end

end

