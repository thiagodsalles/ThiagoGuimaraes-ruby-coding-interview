FactoryBot.define do
  factory :tweet do
    body { Faker::Lorem.sentence(word_count: 10) }
    user { create(:user) }
  end
end
