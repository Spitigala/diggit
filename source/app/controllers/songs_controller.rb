class SongsController < ApplicationController

  def index
    p User.all
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to song_path(@song)
    else
      redirect_to new_song_path
    end
  end

  # def edit
  # end

  # def update
  # end

  def destroy
    Song.find(params[:id]).destroy
    redirect_to root_path
  end

  def upvote
    vote = Vote.get_vote("Song", params[:id], params[:vote][:user_id])
    if vote
      vote.change_vote_to!(1) if vote.value == -1
    else
      Vote.create(vote_params)
    end
    render nothing: true
  end

  def downvote
    vote = Vote.get_vote("Song", params[:id], params[:vote][:user_id])
    if vote
      vote.change_vote_to!(-1) if vote.value == 1
    else
      Vote.create(vote_params)
    end
    render nothing: true
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :album)
  end

  def vote_params
    params.require(:vote).permit(:user_id, :votable, :value)
  end


end
