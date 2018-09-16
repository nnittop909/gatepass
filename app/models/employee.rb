class Employee < User
	validates :id_number, :tag_uid, presence: true
	validates :id_number, :tag_uid, uniqueness: true
end