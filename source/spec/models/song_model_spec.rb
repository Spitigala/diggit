require 'spec_helper'

describe Song do

	context "Instantiation" do 
 		it "can be instantiated" do
    	Song.new.should be_an_instance_of(Song)
  	end
	end
	
	context "Associations" do
		it {should have_many (:votes)}
		it {should have_many (:voters)}
		it {should have_many (:comments)}
		it {should have_many (:commenters)}
	end

	context "Validations" do
		it {should_not allow_value(nil).for(:title)}
		it {should_not allow_value(nil).for(:artist)}
		it {should allow_value("Hit me baby one more time").for(:artist)}
		it {should allow_value("Britney Spears").for(:artist)}
	end

end