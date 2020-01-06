FactoryBot.define do
  factory :comment do
    comment { "MyText" }
    user_id { 1 }
    book_id { 1 }
  end
end
