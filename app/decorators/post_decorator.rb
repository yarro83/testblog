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
end
