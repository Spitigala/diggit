class Vote < ActiveRecord::Base
  validates :value, inclusion: { in: [-1, 1] }
  belongs_to :voteable, polymorphic: true
  belongs_to :voter, class_name: "User", foreign_key: :user_id
end
