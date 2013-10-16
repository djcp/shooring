FactoryGirl.define do
  factory :user do
    name "steve"
    email "steve@example.com"
    password "hunter2" 
    password_confirmation "hunter2" 
  end
end
