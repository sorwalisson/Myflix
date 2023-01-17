FactoryBot.define do
  factory :review do
    headline { "Excellent Movie" }
    description { "Superb movie, with greate fighting scenes, and deep philosophical questions" }
    score { 4 }
    title { nil }
  end
end
