FactoryGirl.define do
  sequence(:user_email) { |n| "person#{n}@example.com" }
  sequence(:admin_email) { |n| "person#{n}@example.com" }

  factory :test_user, class: User do
    email { generate(:user_email) }
    password "testing"
    password_confirmation { "testing" }
    confirmed_at Date.today
  end

  factory :test_admin, class: User do
    email { generate(:admin_email) }
    password "testing"
    password_confirmation { "testing" }
    confirmed_at Date.today
  end
end