class Adjustment < ActiveRecord::Base

  belongs_to :rating
  belongs_to :game

  after_create :recalculate_rating
  after_update :recalculate_rating
  after_destroy :recalculate_rating

  def recalculate_rating
    rating.recalculate
  end

  def positive?
    value >= 0
  end
end
