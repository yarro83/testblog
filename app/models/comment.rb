class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean, default: false
  field :vote_count, type: Integer

  validates_presence_of :body

  belongs_to :user
  belongs_to :post
  has_many :votes

  def became_abusive!
    update_attribute :abusive, true
  end



end
