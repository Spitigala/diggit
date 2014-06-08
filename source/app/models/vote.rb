class Vote < ActiveRecord::Base
  validates :value, inclusion: { in: [-1, 1] }
  belongs_to :voteable, polymorphic: true
  belongs_to :voter, class_name: "User", foreign_key: :user_id

  def self.get_vote(voteable_type, voteable_id, user_id)
    votes = Vote.where(voteable_type: voteable_type).where(voteable_id: voteable_id).where(user_id: user_id)
    raise if votes.count > 1
    votes.first
  end

  def change_vote_to!(value)
    raise unless [1, -1].include?(value)
    self.update_attribute("value", -1)
  end
end
