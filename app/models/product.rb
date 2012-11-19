class Product < ActiveRecord::Base
  has_attached_file :photo, 
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :storage => :dropbox,
  :dropbox_credentials => "#{Rails.root}/config/dropbox.yml"
  has_many :line_items
  before_destroy :not_referenced_by_any_line_item
  attr_accessible :description,:price, :title, :photo
  validates :title,:description, :presence=>true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
 
  private
  def not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base,'Line items present')
      return false
    end
  end
  
end
