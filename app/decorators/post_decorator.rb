class PostDecorator < Draper::Decorator
  decorates :post
  delegate_all

  def friendly_title
    title.gsub(' ', '-').downcase
  end

  def truncated_body
    h.raw h.truncate(body, length: 200, omission: "...")
  end

  def human_comments_count
    human_count = comments.any? ? h.pluralize(comments.count, 'comment') : "No comments"
    h.raw human_count
  end


  def friendly_date
    created_at.strftime("%d/%m/%Y : %H:%M")
  end

  def vote_buttons(comment_id, current_user)
    if (user == current_user) && (comments.find(comment_id).abusive?)
      h.link_to("Mark as not abusive", h.mark_as_not_abusive_post_comment_path(id: comment_id, post_id: id), method: :post, class: "comment__vote-button")
    elsif current_user.can_vote_for?(comment_id)
      h.link_to("Vote Up", h.vote_up_post_comment_path(id: comment_id, post_id: id), method: :post, class: "comment__vote-button") +
      h.raw("&nbsp;") +
      h.link_to("Vote Down", h.vote_down_post_comment_path(id: comment_id, post_id: id), method: :post, class: "comment__vote-button")
    else
      h.raw "You have voted already"
    end
  end
end
