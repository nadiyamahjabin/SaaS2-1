class Movie < ActiveRecord::Base

  def self.ratings
    Movie.select(:rating).map(&:rating).uniq
  end
end
