class Position < ApplicationRecord
  belongs_to :user

  def to_s
  	if title.present?
  		title
  	else
  		"N/A"
  	end
  end
end
