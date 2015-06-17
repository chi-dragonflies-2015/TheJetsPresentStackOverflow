class Question < ActiveRecord::Base
add user auth
  belongs_to :asker, class_name: "User"
end
