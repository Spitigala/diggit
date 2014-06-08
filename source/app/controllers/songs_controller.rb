class SongsController < ApplicationController

  def index
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
    if Vote.where(voteable_type: "Song").find_by(voteable_id: params[:id])
      vote = Vote.where(voteable_type: "Song").find_by(voteable_id: params[:id])
      vote.update_attribute("value", 1)
    else
      Vote.create(vote_params)
    end
    render nothing: true
  end

  def downvote
    if Vote.where(voteable_type: "Song").find_by(voteable_id: params[:id])
      vote = Vote.where(voteable_type: "Song").find_by(voteable_id: params[:id])
      vote.update_attribute("value", -1)
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
