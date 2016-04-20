FactoryGirl.define do
  factory :post do
    sequence(:title)
    body
    goal
    end_date

  end
end
