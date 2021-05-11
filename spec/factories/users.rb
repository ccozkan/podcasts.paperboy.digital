FactoryBot.define do
  factory :user do
    email { "james@bond.com" }
    password { "007doubleO" }
    confirmed_at { Time.current.utc }
  end
end
