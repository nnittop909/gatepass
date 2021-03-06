class Student < User
	
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
                        {:address => 
                            [
                              :sitio,
                              :barangay,
                              :municipality,
                              :province
                            ]
                        }

  belongs_to :course, class_name: "Settings::Course"
  belongs_to :year_level, class_name: "Settings::YearLevel"

  scope :by_course, -> (course_id) { where course_id: course_id }
  scope :by_year_level, -> (year_level_id) { where year_level_id: year_level_id }
  scope :by_status, -> (status) { where status: status }

  def course_and_year
    if self.year_level.present?
      "#{course} - #{year_level}"
    else
      "#{course}"
    end
  end
  
end