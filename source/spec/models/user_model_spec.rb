require 'spec_helper'

describe User do

	context "Instantiation" do 
 		it "can be instantiated" do
    	User.new.should be_an_instance_of(User)
  	end
	end
	
	context "associations" do
		it {should have_many :songs}
		it {should have_many :comments}
		it {should have_many :votes}
	end

end