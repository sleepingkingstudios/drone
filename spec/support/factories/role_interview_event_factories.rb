# spec/support/factories/role_interview_event_factories.rb

FactoryGirl.define do
  factory :role_interview_event, :class => RoleInterviewEvent, :parent => :role_event do
    subtype 'phone'
  end # define
end # define
