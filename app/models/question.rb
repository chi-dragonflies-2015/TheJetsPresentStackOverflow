class Question < ActiveRecord::Base
  belongs_to :asker, class_name: "User"
  belongs_to :best_answer, class_name: "Answer"

  has_many :answers
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def vote_tally
    votes = self.votes.map do |vote|
        vote.value
    end
    votes.reduce(:+)
  end

  def days_ago
    t = Time.now - created_at
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
  end

end
