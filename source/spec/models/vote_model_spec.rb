require 'spec_helper'

describe Vote do

	context "Instantiation" do 
 		it "can be instantiated" do
    	Vote.new.should be_an_instance_of(Vote)
  	end
	end
	
	context "Associations" do
		it {should belong_to :voteable}
		it {should belong_to :voter}
	end

	context "Validations" do
		it {should_not allow_value(nil).for(:value)}
		it {should_not allow_value(5).for(:value)}
		it {should allow_value(1).for(:value)}
		it {should allow_value(-1).for(:value)}
	end

end