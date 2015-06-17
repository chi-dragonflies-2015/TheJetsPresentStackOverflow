class Vote < ActiveRecord::Base
  belongs_to :voter, class_name: "User"
  belongs_to :voteable, polymorphic: true

  validates :value, minimum: -1, maximum:1

end
