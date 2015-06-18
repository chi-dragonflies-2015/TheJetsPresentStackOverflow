class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: "User"
  belongs_to :question
  has_many :votes, as: :voteable
  has_many :comments, as: :voteable

  validates :content, presence: true

end
