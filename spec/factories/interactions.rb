FactoryBot.define do
  factory :interaction do
    user { nil }
    episode { nil }
    dismissed { false }
  end
end
