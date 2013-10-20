class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String
  field :abusive, type: Boolean

  validates_presence_of :body

  belongs_to :user
  belongs_to :post

  def became_abusive!
    update_attribute :abusive, true
  end
end
