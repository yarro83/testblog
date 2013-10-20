class Vote
  include Mongoid::Document
  
  field :value, type: Integer

  belongs_to :user
  belongs_to :comment

  after_create :check_if_became_abusive

  private

  def check_if_became_abusive
    if self.comment.votes.map(&:value).inject(:+) < -2
      self.comment.update_attribute(:abusive, true)
    end
  end
end
