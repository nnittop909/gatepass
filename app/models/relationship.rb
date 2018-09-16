class Relationship < ApplicationRecord
  belongs_to :guardian
  belongs_to :user
  validates :relation, presence: true

  def to_s
  	relation.titleize
  end
end
