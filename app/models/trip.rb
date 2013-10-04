class Trip < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :verses
  has_one :comment
  attr_accessible :name, :tripit_id, :image_url, :start_date, :end_date

  def past?(trueval = true, falseval = false)
    if DateTime.now > end_date
      return trueval
    else
      return falseval
    end
  end
end
