class ListItem < ActiveRecord::Base
  belongs_to :location
  belongs_to :list
  attr_accessible :description
end
