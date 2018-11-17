class CourseDuration < ApplicationRecord
  has_many :courses

  validates :name, :duration, presence: true

  def to_s
  	name
  end
  
end
