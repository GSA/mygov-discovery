class Rating < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :page
  has_one :user
  
  attr_accessible :page_id, :value
  validates_uniqueness_of :value, :scope => [ :page_id, :user_id ]
  validates_presence_of :user_id, :page_id, :value
  
  after_save :update_cache
  before_validation :set_user
  
  def set_user
    if self.user_id.nil?
      self.user_id = current_user.id unless current_user.nil?
    end
  end
  
  def update_cache
    avg = Rating.average( :value, :conditions => [ 'page_id = ?', page_id ] ) 
    Page.find(page_id).update_attribute( :rating, avg )
  end
  
end
