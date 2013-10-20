class CommentDecorator < Draper::Decorator
  decorates :comment
  delegate_all


end
