class Song < ActiveRecord::Base
  has_many :votes, as: :voteable
  has_many :comments
  belongs_to :user
end
