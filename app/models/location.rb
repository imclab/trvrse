#
# Copyright 2008-2013 Concur Technologies, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

class Location < ActiveRecord::Base
  attr_accessible :lat, :long, :name
  has_many :trips
  has_many :comments, :through => :trips
  has_many :verses, :through => :trips
  has_many :lists, :through => :list_items
  serialize :image

  def self.random(options = {})
    count = self.count()
    self.find(:first, options.merge(:offset => rand(count)))
  end

  def get_description
    load_from_wikipedia
    description
  end

  def get_image
    load_from_wikipedia
    user_image = Verse.joins(:locations).where('locations.id = ?', self.id).group('verses.id').sample

    if user_image != nil and rand > 0.5
      return user_image.image(:bg)
    elsif image
      return image.sample
    elsif user_image
      return user_image.image(:bg)
    else
      nil
    end
  end

  def rating
    avg = 0.0

    comments.each do |c|
      avg += c.rating
    end
    if avg > 0
      avg = (avg / comments.count).round
    end

    return avg
  end

  def visited?(iuser)
    if Trip.where({user_id: iuser, location_id: id}).count > 0
      true
    else
      false
    end
  end
  private
    def load_from_wikipedia
      return if (updated_at >= 2.days.ago and (image.nil? == false))
      puts '#############################'
      puts 'LOADING FROM WIKIPEDIA'
      puts '#############################'
      wiki = Wikipedia.find(name, :prop => %w{ revisions links images categories})

      # if true, theres content, if false, there is no page, so just use
      # a default description
      if wiki.sanitized_content
        puts "FOUND YAYAYAYAY content - #{wiki.raw_data.inspect}"
        self.description = wiki.sanitized_content.gsub(/\(.*?\)/, "").gsub(/\<.*?\>/, "")[0,500]
      else
        puts "DID NOT FIND. BOO HOO."
        self.description = nil
      end

      if wiki.images
        imgs = wiki.images

        puts imgs.to_s
        imgs.reject! do |img|
          if img.include? ".svg" or img.include? ".png"
            true
          else
            false
          end
        end
        puts imgs.to_s

        if imgs.count > 0
          imgs = imgs.slice(0..4)
          puts imgs.to_s
          img_sources = []
          imgs.each do |i|
            puts i
            img_sources << Wikipedia.find_image(i, :iiurlwidth => '300').thumb_url
          end
          self.image = img_sources
          puts "#########" + self.image.to_s
        else
          self.image = nil
        end
      else
        self.image = nil # just set it to a blank image
      end

      self.updated_at = Time.now
      self.save
    end
end
