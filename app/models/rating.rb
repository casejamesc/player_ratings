class Rating < ActiveRecord::Base

  DEFAULT_RATING = 1600

  belongs_to :player
  has_many :adjustments

  def custom(filter={})
    adjustments.where(filter).sum(&:value)
  end

  def recalculate
    update_attributes value: DEFAULT_RATING + adjustments.sum(:value)
  end
end
