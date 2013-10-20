class CommentsController < ApplicationController
  expose(:post)
  expose_decorated(:comments) { post.comments }
  expose_decorated(:comment)

  def create
    if comment.save
      redirect_to comment.post, notice: "Comment has been added"
    else
      redirect_to post, alert: "Please fill your message"
    end
  end
end
