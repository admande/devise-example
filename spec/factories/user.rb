FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| 'adam.mandeville#{n}@gmail.com' }
    first_name 'John'
    last_name 'Smith'
    password 'password'
    password_confirmation 'password'
  end
end
