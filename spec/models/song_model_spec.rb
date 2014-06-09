require 'spec_helper'

describe Song do

	context "Instantiation" do 
 		it "can be instantiated" do
    	Song.new.should be_an_instance_of(Song)
  	end
	end
	
	context "associations" do
		it {should have_many (:votes)}
		it {should have_many (:comments)}
	end

end