FactoryBot.define do
  factory :user do
    email { "test@hotmail.com" }
    password { "justtesting" }
    name { "Peter Griffin" }
    active { true }
  end
end
