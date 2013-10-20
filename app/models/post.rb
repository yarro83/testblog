class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ne(archived: true)

  def archive!
    update_attribute :archived, true
  end

  def hotness
    ret = self.comments.count / 3
    if (created_at + 24.hours) >= DateTime.now
      return ret + 3
    elsif ((created_at + 24.hours) <= DateTime.now) && ((created_at + 72.hours) >= DateTime.now)
      return ret + 2
    elsif (created_at + 3.days) <= DateTime.now && (created_at + 7.days) >= DateTime.now
      return ret + 1
    else
      return ret
    end
  end

end
