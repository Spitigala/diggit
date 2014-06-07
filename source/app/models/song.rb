class Song < ActiveRecord::Base
  has_many :votes, as: :voteable
  has_many :voters, through: :votes
  has_many :comments
  has_many :commenters, through: :comments, class_name: "User"
  belongs_to :uploader, class_name: "User", foreign_key: :user_id
end
