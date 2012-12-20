class Rating < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :page
  has_one :user
  
  attr_accessible :page_id, :value
  validates_uniqueness_of :page_id, :scope => :user_id
  validates_presence_of :user_id, :page_id, :value
  validates :value, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5 }
  
  after_save :update_cache
  before_validation :set_user
  
  def set_user
    if self.user_id.nil?
      self.user_id = @current_user unless @current_user.nil?
    end
  end
  
  def update_cache
    avg = Rating.average( :value, :conditions => [ 'page_id = ?', page_id ] ) 
    Page.find(page_id).update_attribute( :avg_rating, avg )
  end
  
end