class CommentsController < ApplicationController
  expose(:post)
  expose_decorated(:comments) { post.comments }
  expose_decorated(:comment)

  before_filter :prevent_double_votes, only: [:vote_up, :vote_down]

  def create
    if comment.save
      redirect_to comment.post, notice: "Comment has been added"
    else
      redirect_to post, alert: "Please fill your message"
    end
  end

  def mark_as_not_abusive
    comment.update_attributes(abusive: false)
    redirect_to post, notice: "Vote has been marked as non-abusive"
  end

  def vote_down
    comment.votes.create(value: -1, user_id: current_user.id)
    comment.reload
    if comment.votes.map(&:value).inject(:+) < -2 
      comment.update_attributes(abusive: true)
    end
    redirect_to post, notice: "Your vote has been saved"
  end

  def vote_up
    comment.votes.create(value: 1, user_id: current_user.id)
    redirect_to post, notice: "Your vote has been saved"
  end

  private

  def prevent_double_votes
    unless current_user.can_vote_for?(comment)
      redirect_to post, alert: "You have voted already"
    end
  end
end
