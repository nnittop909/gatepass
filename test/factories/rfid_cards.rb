FactoryBot.define do
  factory :rfid_card do
    id_number { "MyString" }
    rfid_uid { 1 }
    student { nil }
  end
end
