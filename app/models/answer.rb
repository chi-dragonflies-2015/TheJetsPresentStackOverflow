class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: "User"
  belongs_to :question
  has_many :votes, as: :voteable
  has_many :comments, as: :voteable
  has_one :question_answered_best, class_name: "Question", foreign_key: "best_answer_id"

  validates :content, presence: true

end
