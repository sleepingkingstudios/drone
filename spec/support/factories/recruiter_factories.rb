# spec/support/factories/recruiter_factories.rb

FactoryGirl.define do
  factory :recruiter do
    sequence(:name) { |index| "Recruiter #{index}" }
  end # factory
end # define
