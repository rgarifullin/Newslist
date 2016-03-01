FactoryGirl.define do
  factory :times_news, class: News do
    author 'Jimmy'
    text 'The New York Times magazine published their last issue.'
  end

  factory :rome_news, class: News do
    author 'Caesar'
    text 'Caesar is the best emperor in the whole world, seriously!'
  end
end
