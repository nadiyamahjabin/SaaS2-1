class Movie < ActiveRecord::Base

  def self.ratings
    Movie.find(:all, :select => 'distinct rating').map(&:rating)
  end
end
