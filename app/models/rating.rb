class Rating < ActiveRecord::Base
  belongs_to :page
  belongs_to :user

  validates_uniqueness_of :page_id, :scope => :user_id
  validates_presence_of :user_id, :page_id, :value
  validates :value, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5 }
  
  after_save :update_average_rating

  attr_accessible :value

  def as_json
    super(:only => [:page_id, :value])
  end
    
  private
  
  def update_average_rating
    self.page.avg_rating = Rating.average(:value, :conditions => ['page_id = ?', self.page.id])
    self.page.save
  end  
end