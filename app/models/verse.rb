class Verse < ActiveRecord::Base
  belongs_to :user
  belongs_to :point
  belongs_to :trip
  has_many :likes
  has_many :locations, :through => :trip
  attr_accessible :caption, :tags, :image, :lat, :long, :trip_id
  has_attached_file :image, :styles => { :medium => "600x600#", :bg => "300x300#", :thumb => "100x100#" }
end
