require 'spec_helper'

describe Comment do

	context "Instantiation" do 
 		it "can be instantiated" do
    	Comment.new.should be_an_instance_of(Comment)
  	end
	end
	
	context "Associations" do
		it {should have_many :votes}
		it {should belong_to :song}
		it {should belong_to :commenter}
		it {should have_many :voters}
		it {should have_many :replies}
	end

	context "Validations" do 
		it {should_not allow_value(nil).for(:content)}
		it {should allow_value("Test Comment").for(:content)}
	end

end