class Address < ApplicationRecord
	belongs_to :user, optional: true
  belongs_to :guardian, optional: true
  
  validates :municipality, :province, presence: true
  def to_s
  	details
  end

  def details
  	if self.sitio.present? && self.barangay.present?
    	"#{sitio}, #{barangay}, #{municipality}, #{province}"
    elsif self.sitio.blank? && self.barangay.present?
    	"#{barangay}, #{municipality}, #{province}"
    elsif self.sitio.blank? && self.barangay.blank?
    	"#{municipality}, #{province}"
    end
  end
end
