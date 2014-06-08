require 'rails_helper'

describe CommentsController do
  let!(:user) { create :user }
  let!(:comment) { create :comment }
  let!(:song) { create :song }

  context '#create' do
    it 'with valid attributes' do
      session[:user_id] = user.id
      expect{
        post :create, song_id: song, comment: { content: "This is an awesome song" }
        expect(response).to be_success
      }.to change(Comment, :count).by(1)
    end

    it 'with invalid attributes' do
      session[:user_id] = user.id
      expect {
        post :create, song_id: song, comment: { content: nil }
      }.to_not change(Comment, :count)
    end
  end

  context '#edit' do
    before(:each) do
      get :edit, song_id: comment.song.id, id: comment.id
    end
    it 'is successful' do
      expect(response).to be_success
    end

    it 'assigns instance of comment to Comment record' do
      expect(assigns(:comment)).to eq comment
    end

    it 'renders edit comment page' do
      expect(response).to render_template :edit
    end
  end

  context '#update' do
    context 'with valid attributes' do

      it 'redirects to song path' do
        put :update, song_id: comment.song.id, id: comment.id, comment: { content: "This is also an awesome song"}
        expect(response).to redirect_to song_path(comment.song)
      end

      it 'updates the comment in the database' do
        put :update, song_id: comment.song.id, id: comment.id, comment: { content: "This is also an awesome song"}
        comment.reload
        expect(comment.content).to eq "This is also an awesome song"
      end
    end

    context 'with invalid attributes' do
      it 'redirects to edit_song_comment_path' do
        put :update, song_id: comment.song.id, id: comment.id, comment: { content: nil}
        expect(response).to redirect_to edit_song_comment_path(comment.song, comment)
      end

      it 'does not update the comment in the database' do
        put :update, song_id: comment.song.id, id: comment.id, comment: { content: nil}
        comment.reload
        expect(comment.content).to_not eq nil
      end
    end

  end

  context '#destroy' do
    it "deletes specified comment" do
      expect{
        delete :destroy, song_id: comment.song.id, id: comment.id
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to show song page" do
      delete :destroy, song_id: comment.song.id, id: comment.id
      expect(response).to redirect_to song_path(comment.song)
    end
  end

  context '#upvote' do
    it 'create new vote record if user has not already voted' do
      Vote.create(user_id: user.id, voteable: comment, value: 1)
      user2 = User.create(username: "voter2", password: "password", password_confirmation: "password")
        expect {
          post :upvote, song_id: comment.song, id: comment, vote: {user_id: user2.id, voteable: comment, value: 1}
        }.to change(Vote, :count).by(1)
    end

    it 'does NOT create new vote record if user has already voted' do
      Vote.create(user_id: user.id, voteable: comment, value: 1)
      expect {
        post :upvote, song_id: comment.song, id: comment, vote: {user_id: user.id, voteable: comment, value: 1}
      }.to_not change(Vote, :count)
    end
  end

  context '#downvote' do
    it 'creates new vote record if user has not already voted' do
      Vote.create(user_id: user.id, voteable: comment, value: 1)
      user2 = User.create(username: "voter2", password: "password", password_confirmation: "password")
      expect {
        post :downvote, song_id: comment.song, id: comment, vote: {user_id: user2.id, voteable: comment, value: -1}
      }.to change(Vote, :count).by(1)
    end

    it 'does NOT create new vote record if user has already voted' do
      Vote.create(user_id: user.id, voteable: comment, value: 1)
      expect {
        post :downvote, song_id: comment.song, id: comment, vote: {user_id: user.id, voteable: comment, value: -1}
      }.to_not change(Vote, :count)
    end
  end
end

