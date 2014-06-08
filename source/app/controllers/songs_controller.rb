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
    puts ">>params[:vote] #{params[:vote]}"
    puts ">>song_id: #{params[:id]}"
    puts ">>All users"
    p User.all
    puts ".."
    puts ">>All Votes"
    p Vote.all
    puts ".."
    puts ">>Previous vote if any"
    p Vote.where(voteable_type: "Song").where(voteable_id: params[:id]).where(user_id: params[:user_id])
    puts ".."
    unless Vote.where(voteable_type: "Song").where(voteable_id: params[:id]).where(user_id: params[:vote][:user_id]).empty?
      puts "<<<<<<<<<< user already voted >>>>>>>>>>"
      raise if Vote.where(voteable_type: "Song").where(voteable_id: params[:id]).where(user_id: params[:vote][:user_id]).count > 1
      vote = Vote.where(voteable_type: "Song").where(voteable_id: params[:id]).where(user_id: params[:vote][:user_id])[0]
      vote.update_attribute("value", 1)
    else
      puts "<<<<<<<<<< new vote >>>>>>>>>>"
      Vote.create(vote_params)
    end
    render nothing: true
  end

  def downvote
    unless Vote.where(voteable_type: "Song").where(voteable_id: params[:id]).where(user_id: params[:vote][:user_id]).empty?
      raise if Vote.where(voteable_type: "Song").where(voteable_id: params[:id]).where(user_id: params[:vote][:user_id]).count > 1
      vote = Vote.where(voteable_type: "Song").where(voteable_id: params[:id]).where(user_id: params[:vote][:user_id])[0]
      vote.update_attribute("value", 1)
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
