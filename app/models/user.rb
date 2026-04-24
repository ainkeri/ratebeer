class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 4 }, format: { with: /\A(?=.*[A-Z])(?=.*[0-9]).{4,}.*\z/, message: "must include one uppercase letter and one number" }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    ratings.group_by{ |r| r.beer.style }.map{ |b, r| [b, r.sum(&:score)] }.max_by{ |_, s| s }.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    ratings.group_by{ |r| r.beer.brewery.name }.map{ |b, r| [b, r.sum(&:score)] }.max_by{ |_, r| r }.first
  end
end
