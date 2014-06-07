require 'rails_helper'

describe UsersController do
  let!(:user) { create :user }

  context '#show' do
    it "is successful" do
      # expect(build(:user)).to be_valid
      # expect(true).to eq false
      # expect(user).to be_valid
      get :show, id: user.id
      expect(response).to be_success
    end
  end


end
