FactoryGirl.define do
  factory :article, class: Article do
    slug { FFaker::Internet.slug }
    headline { FFaker::Lorem.sentence }
  end
end
