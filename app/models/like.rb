class Like < ActiveRecord::Base
  belongs_to :verse
  belongs_to :user
  # attr_accessible :title, :body
  
  def self.like_this(verse, user)
    like = self.where(:verse_id => verse.id, :user_id => user.id)
    if like.first
      like.first.destroy
    else
      like.first_or_create
    end
  end

  def self.d?(verse, user)
    self.where(:verse_id => verse.id, :user_id => user.id).first
  end

  def self.s(verse)
    self.where(:verse_id => verse.id).count
  end
end
