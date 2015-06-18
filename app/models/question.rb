class Question < ActiveRecord::Base

  belongs_to :asker, class_name: "User"
  has_many :answers
  has_many :comments, as: :commenteable
  has_many :votes, as: :voteable


  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  def days_ago
    t = Time.now - created_at
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
  end

end
