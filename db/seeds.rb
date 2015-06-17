require 'faker'

jack = User.create!(first_name:"Jack", last_name: "McCallum",email: "mcca@aol.com", password: "abc")
User.create!(first_name:"Henry", last_name: "Firth",email: "h12@aol.com", password: "123")


20.times do
  question =  Question.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    asker_id: rand(100),
    best_answer_id: rand(100))
  5.times do
    question.comments << Comment.create!(content: Faker::Lorem.sentence, commenter_id: 2)
  end
  jack.questions << question
end
