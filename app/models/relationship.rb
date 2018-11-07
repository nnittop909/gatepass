class Relationship < ApplicationRecord
  belongs_to :guardian
  belongs_to :student, class_name: "User", foreign_key: "user_id"
  validates :relation, presence: true

  def to_s
  	relation.titleize
  end
end
