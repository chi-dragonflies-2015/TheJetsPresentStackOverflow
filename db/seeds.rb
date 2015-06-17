require 'faker'
20.times do
    question =  Question.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    asker_id: rand(100),
    best_answer_id: rand(100))
  5.times do
    question.comments << Comment.create!(content: Faker::Lorem.sentence)
  end
end