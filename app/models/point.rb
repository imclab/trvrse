class Point < ActiveRecord::Base
  belongs_to :place
  has_many :verses
  attr_accessible :lat, :long, :name
end
