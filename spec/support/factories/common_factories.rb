# spec/support/factories/common_factories.rb

FactoryGirl.define do
  sequence(:id) { BSON::ObjectId.new.to_s }
end # define
