class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_value
      t.voteable, polymorphic: true

      t.timestamps
    end
  end
end
