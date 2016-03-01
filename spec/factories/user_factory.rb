FactoryGirl.define do
  factory :user, class: User do
    email 'viewer@example.com'
    password 'newpassword'
    role 0
  end

  factory :admin, class: User do
    email 'admin@example.com'
    password 'expassword'
    role 1
  end
end
