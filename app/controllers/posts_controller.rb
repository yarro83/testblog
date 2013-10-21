class PostsController < ApplicationController
  before_filter :authenticate_user!
  expose_decorated(:posts)
  expose_decorated(:post)
  expose_decorated(:comments) { (current_user == post.user) ? post.comments : post.comments.where(abusive: false) }

  expose(:tag_cloud) do
    Post.all.inject([]) do |result, element|
      element.tags_array.map(&:to_s).each do |tag|
        if result.map(&:first).include?(tag)
          tag_entity_count = result.select{ |el| el.first == tag }.first.pop + 1.0
          result.select{ |el| el.first == tag }.first << tag_entity_count

        else 
          result << [tag, 1.0]
        end
      end
      result
    end.sort_by{ |el| el.last}
  end

  def index
  end

  def new
  end

  def edit
  end

  def update
    if post.save
      render action: :index
    else
      render :new
    end
  end

  def destroy
    post.destroy if current_user.owner? post
    render action: :index
  end

  def show
  end

  def mark_archived
    post.archive!
    render action: :index
  end

  def create
    if post.save
      current_user.posts << post
      redirect_to action: :index
    else
      render :new
    end
  end

end
