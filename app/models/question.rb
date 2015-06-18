class Question < ActiveRecord::Base

  belongs_to :asker, class_name: "User"
  has_many :answers
  has_many :comments, as: :commenteable
  has_many :votes, as: :voteable


  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def vote_tally
    votes = self.votes.map do |vote|
        vote.value
    end
    votes.reduce(:+)
  end

end
