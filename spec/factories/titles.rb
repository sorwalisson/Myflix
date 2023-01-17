FactoryBot.define do
  factory :title do
    name { "Matrix" }
    genre { 0 }
    available { true }
    content_rating { "18+" }
    kind { 0 }
    title_information { "{director: 'Lilly and Lana Wachowski, casting: ['Keanu Reeves', 'Laurence Fishburn', 'Carrie-Anne Moss', 'Hugo Weaving']}" }
    featured { false }
  end
end
