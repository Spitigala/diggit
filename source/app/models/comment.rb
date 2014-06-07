class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: "User", foreign_key: :user_id
  belongs_to :song
  has_many :votes, as: :voteable
  has_many :voters, through: :votes

  has_many :replies, class_name: "Comment", foreign_key: :parent_id
  belongs_to :parent, class_name: "Comment"
end
