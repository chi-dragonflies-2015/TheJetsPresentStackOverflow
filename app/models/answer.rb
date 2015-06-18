class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: "User"
  belongs_to :question
  has_many :votes, as: :voteable
  has_one :question_answered_best, class_name: "Question", foreign_key: "best_answer_id"
  has_many :comments, as: :commentable

  validates :content, presence: true

  def vote_tally
    votes = self.votes.map do |vote|
        vote.value
    end
    votes.reduce(:+)
  end


end
