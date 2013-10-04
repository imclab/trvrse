class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items
  has_many :locations, :through => :list_items
  attr_accessible :description, :to_what

  def name(short = false)
    if short
      "The #{list_items.count} best places to #{to_what}"
    else
      "The #{list_items.count} best places in the world to #{to_what}"
    end
  end
end
