class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        total_ratings = ratings.reduce(0) { |sum, rating| sum + rating.score }
        (total_ratings / ratings.count).to_f
    end

    def to_s
      "#{name} (#{brewery.name})"
    end
end
