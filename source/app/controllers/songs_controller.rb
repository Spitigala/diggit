class SongsController < ApplicationController
  helper_method :embed

  def index
    @songs = Song.all
  end

  def show
    @comment = Comment.new
    @song = Song.find(params[:id])
    @song_comments = @song.comments.sort_by &:created_at
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
    puts "[LOG] params: #{params.inspect}"
    puts "[LOG] user_id: #{params[:vote][:user_id]}"
    vote = Vote.get_vote("Song", params[:id], params[:vote][:user_id])
    if vote
      puts "[LOG] inside if-- vote exists"
      vote.change_vote_to!(1) if vote.value == -1
    else
      puts "[LOG] inside else-- new vote"
      puts "[LOG] prepare_vote_params: #{prepare_vote_params(vote_params)}"
      Vote.create(prepare_vote_params(vote_params))
    end
    render nothing: true
  end

  def downvote
    vote = Vote.get_vote("Song", params[:id], params[:vote][:user_id])
    if vote
      vote.change_vote_to!(-1) if vote.value == 1
    else
      Vote.create(prepare_vote_params(vote_params))
    end
    render nothing: true
  end

  def embed(song_url)
    client = Soundcloud.new(client_id: 'aa14d6213fea0d5d0dce993ef44097e2')
    embed_info = client.get('/oembed', :url => song_url)

    return embed_info['html']
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist, :url)
  end

  def vote_params
    params.require(:vote).permit(:user_id, :voteable_id, :voteable_type, :value)
  end

  def prepare_vote_params(vote_params)
    prepared_params = vote_params
    prepared_params['user_id'] = vote_params['user_id'].to_i
    prepared_params['voteable_id'] = vote_params['voteable_id'].to_i
    prepared_params['value'] = vote_params['value'].to_i
    prepared_params
  end

end
