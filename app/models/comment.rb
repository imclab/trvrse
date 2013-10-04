class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  attr_accessible :content, :rating
end
