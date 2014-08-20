# spec/support/factories/role_factories.rb

FactoryGirl.define do
  factory :role do
    sequence(:company) { |index| "Ominous Corporate Overlords, Division #{index}" }

    state { 'open' }
  end # factory
end # define
