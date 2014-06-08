class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true
  has_many :songs
  has_many :votes
  has_many :comments

  def self.authenticate username, password 
    begin
      User.find_by_username( username ).authenticate( password )
    rescue
      return nil
    end  
  end
end
