class Song < ActiveRecord::Base
  has_many :votes, as: :voteable
  belongs_to :user
end
