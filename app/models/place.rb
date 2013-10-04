class Place < ActiveRecord::Base
  attr_accessible :city_name, :display_name, :id, :latitude, :longitude, :state_code

  has_many :points
end
