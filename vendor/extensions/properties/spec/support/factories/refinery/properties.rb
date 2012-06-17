
FactoryGirl.define do
  factory :property, :class => Refinery::Properties::Property do
    sequence(:lot_number) { |n| "refinery#{n}" }
  end
end

