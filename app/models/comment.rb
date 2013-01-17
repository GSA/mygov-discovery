class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :page
  has_one :user
  
  attr_accessible :body
  validates_uniqueness_of :body, :scope => [ :page_id, :user_id ]
  validates_presence_of :user_id, :page_id, :body

  before_validation :set_user
  
  self.per_page = 25
  
  def set_user
    if self.user_id.nil?
      self.user_id = @current_user unless @current_user.nil?
    end
  end
  
end