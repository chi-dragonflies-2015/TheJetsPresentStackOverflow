require 'faker'


jack = User.create!(first_name:"Jack", last_name: "McCallum",email: "mcca@aol.com", password: "abc")


20.times do
  question =  Question.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    asker_id: rand(100),
    best_answer_id: rand(100))

  jack.questions << question
end
