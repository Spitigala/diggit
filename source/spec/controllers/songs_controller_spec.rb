require 'rails_helper'

describe SongsController do
  let!(:song) { create :song }
  let!(:user) { create :user }

  context '#index' do
    it 'is sucessful' do
      get :index
      expect(response).to be_success
    end

    it 'assigns all songs to @songs' do
      get :index
      expect(assigns(:songs).length).to eq 1
    end

    it 'renders an index page' do
      get :index
      expect(response).to render_template :index
    end
  end

  context '#show' do
    it 'is successful' do
      get :show, id: song
      expect(response).to be_success
    end

    it 'assigns requested song to @song' do
      get :show, id: song
      expect(assigns(:song)).to eq song
    end

    it 'renders a show page' do
      get :show, id: song
      expect(response).to render_template :show
    end
  end

  context '#new' do
    it 'is successful' do
      get :new
      expect(response).to be_success
    end

    it 'renders new song page' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns instance of song to @song' do
      get :new
      expect(assigns(:song)).to be_a Song
    end
  end

  context '#create' do
    it 'with valid attributes' do
      expect {
        post :create, song: attributes_for(:song)
        expect(response).to redirect_to song_path(assigns(:song))
      }.to change(Song, :count).by(1)
    end

    it 'with invalid attributes' do
      expect {
        post :create, song: attributes_for(:invalid_song)
        expect(response).to redirect_to new_song_path
      }.to_not change(Song, :count)
    end
  end

  context '#destroy' do
    it 'deletes specified song' do
      expect {
        delete :destroy, id: song
      }.to change(Song, :count).by(-1)
    end
  end

  context '#upvote' do
    it 'create new vote record if user has not already voted' do
    Vote.create(user_id: user.id, voteable: song, value: 1)
    user2 = User.create(username: "voter2", password: "password", password_confirmation: "password")
      expect {
        post :upvote, id: song, vote: {user_id: user2.id, voteable: song, value: 1}
      }.to change(Vote, :count).by(1)
    end

    it 'does NOT create new vote record if user has already voted' do
      Vote.create(user_id: user.id, voteable: song, value: 1)
      expect {
        post :upvote, id: song, vote: {user_id: user.id, voteable: song, value: 1}
      }.to_not change(Vote, :count)
    end
  end

  context '#downvote' do
    it 'creates new vote record if user has not already voted' do
      Vote.create(user_id: user.id, voteable: song, value: 1)
      user2 = User.create(username: "voter2", password: "password", password_confirmation: "password")
      expect {
        post :downvote, id: song, vote: {user_id: user2.id, voteable: song, value: -1}
      }.to change(Vote, :count).by(1)
    end

    it 'does NOT create new vote record if user has already voted' do
      Vote.create(user_id: user.id, voteable: song, value: 1)
      expect {
        post :upvote, id: song, vote: {user_id: user.id, voteable: song, value: 1}
      }.to_not change(Vote, :count)
    end
  end

end
