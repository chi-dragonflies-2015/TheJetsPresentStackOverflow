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

bob = User.create!(first_name:"bob", last_name: "bob",email: "bob", password: "bob")
 quest =  Question.create!(
    title: "All Work and No Play?",
    content: Faker::Lorem.sentence )

my_votes = Vote.create!(
    value: 1)


quest.votes << my_votes

bob.questions << quest
