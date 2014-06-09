require 'json'

class CommentsController < ApplicationController

  def create
    #comments create from show_song_path
    #params coming from ajax
    comment = Comment.new(comment_params)
    comment.user_id = session[:current_user_id]
    comment.song_id = params[:song_id].to_i

    respond_to do |format|
      if comment.save
        response = {content: comment.content, user_id: comment.user_id, username: comment.commenter.username}
        format.json { render :json => response}
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    song = Song.find(params[:song_id])
    new_content = comment_params['content']

    if new_content
      comment.update_attribute('content', new_content)
      redirect_to song_path(song)
    else
      flash[:error] = comment.errors.full_messages
      redirect_to edit_song_comment_path(song, comment)
    end
  end

  def destroy #takes place on the comment edit page
    Comment.find(params[:id]).destroy
    redirect_to song_path(params[:song_id])
  end

  def upvote
    puts "[LOG] params: #{params.inspect}"
    puts "[LOG] user_id: #{params[:vote][:user_id]}"
    vote = Vote.get_vote("Comment", params[:id], params[:vote][:user_id])
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
    vote = Vote.get_vote("Comment", params[:id], params[:vote][:user_id])
    if vote
      vote.change_vote_to!(-1) if vote.value == 1
    else
      Vote.create(prepare_vote_params(vote_params))
    end
    render nothing: true
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :song_id)
  end

  def vote_params
    params.require(:vote).permit(:user_id, :voteable_id, :voteable_type, :value)
  end

  def prepare_vote_params(vote_params)
    prepared_params = vote_params
    prepared_params['user_id'] = vote_params['user_id'].to_i
    puts "[LOG] inside prepare_vote_params-- voteable_id: #{prepared_params['voteable_id']}"
    prepared_params['voteable_id'] = vote_params['voteable_id'].to_i
    puts "[LOG] inside prepare_vote_params-- voteable_id: #{prepared_params['voteable_id']}"
    prepared_params['value'] = vote_params['value'].to_i
    prepared_params
  end

end
