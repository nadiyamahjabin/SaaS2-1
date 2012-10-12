class Movie < ActiveRecord::Base

  def self.ratings
    Movie.group(:rating).map { |movie| movie.rating }
  end
end
