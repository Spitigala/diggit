class CommentsController < ApplicationController

  def create
    #comments create from show_song_path
    #params coming from ajax
    puts "^" * 100
    p params
    comment = Comment.new(comment_params)
    comment.user_id = session[:user_id]
    comment.song_id = params[:song_id]
    if comment.save
      render nothing: true
      return {content: comment.content, user_id: comment.user_id}
    else
      flash[:error] = comment.errors.full_messages
      render nothing: true
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
    vote = Vote.get_vote("Comment", params[:id], params[:vote][:user_id])
    if vote
      vote.change_vote_to!(1) if vote.value == -1
    else
      Vote.create(vote_params)
    end
    render nothing: true
  end

  def downvote
    vote = Vote.get_vote("Comment", params[:id], params[:vote][:user_id])
    if vote
      vote.change_vote_to!(-1) if vote.value == 1
    else
      Vote.create(vote_params)
    end
    render nothing: true
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def vote_params
    params.require(:vote).permit(:user_id, :votable, :value)
  end

end
