FactoryGirl.define do
  factory :user do
    name "steve"
    email "sample@example.com"
    password "hunter2" 
    password_confirmation "hunter2" 
  end
end
