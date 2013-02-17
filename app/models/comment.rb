class Comment < ActiveRecord::Base
  belongs_to :page
  belongs_to :user
  
  attr_accessible :body
  validates_uniqueness_of :body, :scope => [ :page_id, :user_id ]
  validates_presence_of :user_id, :page_id, :body

  self.per_page = 25

  def as_json(options = {})
    super(:only => [:id, :page_id, :body, :created_at])
  end
end