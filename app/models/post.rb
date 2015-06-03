class Post < ActiveRecord::Base


  INDEX_DETAILS = %w(
    posts.slug
    posts.title
    users.first_name
    users.last_name
    posts.posted_date
    posts.excerpt
  )


  SHOW_DETAILS = %w(
    posts.slug
    posts.title
    users.first_name
    users.last_name
    posts.posted_date
    posts.content
  )


  belongs_to :post_category
  belongs_to :user

  before_save :update_slug

  def self.index_details
    select(INDEX_DETAILS).joins(:user).where("posts.status = 1").order("posts.id DESC")
  end

  def self.show_details id
     select(SHOW_DETAILS).joins(:user).where("posts.status = 1").find(id)
  end

  def author
    "#{first_name} #{last_name}"
  end

  private

  def update_slug
    self.slug = self.id.to_s+"-"+self.title.parameterize
  end

end