class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true
  has_many :songs
  has_many :votes
  has_many :comments
end
