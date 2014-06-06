class Comment < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :voteable

  has_many :replies, class_name: "Comment", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Comment"
end
