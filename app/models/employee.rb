class Employee < User

	include Filterable
  include PgSearch

  pg_search_scope :search_by_name, 
                  :against => 
                      [
                        :full_name, 
                        :first_name, 
                        :middle_name, 
                        :last_name,
                        :id_number,
                        :rfid_uid,
                        :mobile
                      ],
                  :associated_against => 
                        {
                        	:address => 
	                          [
	                            :sitio,
	                            :barangay,
	                            :municipality,
	                            :province
	                          ],
	                        :position => 
	                          [:title]
                        }


	def to_s
		title
	end
end