FactoryBot.define do
  factory :group_event do
    name 'A test group event'
    start_date DateTime.now
    end_date DateTime.now + 7
  end
end
