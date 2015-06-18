class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: "User"
  belongs_to :question
  has_many :votes, as: :voteable
  has_many :comments, as: :voteable

  validates :content, presence: true

  def vote_tally
    votes = self.votes.map do |vote|
        vote.value
    end
    votes.reduce(:+)
  end


end
