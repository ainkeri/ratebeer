module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    total_ratings = ratings.reduce(0) { |sum, rating| sum + rating.score }
    (total_ratings / ratings.count).to_f
  end
end
