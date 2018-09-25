class Student < User
	
  include Filterable

  belongs_to :course
  belongs_to :year_level

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

  def age
    if self.birthdate.present?
      ((Date.today - self.birthdate.to_date) / 365).floor
    else
      "N/A"
    end
  end

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     Student.where(id_number: row['id_number'], first_name: row['first_name'], last_name: row['last_name']).first_or_create do |student|
  #       student.course_id = Course.find_by(abbreviation: row['course']).id
  #       student.year_level_id = YearLevel.find_by(name: row['year_level']).id
  #       student.middle_name = row['middle_name']
  #       student.gender = row['gender'].to_s.downcase
  #       student.birthdate = row['birthdate']
  #       student.mobile = row['mobile']
  #       student.tag_uid = row['card_uid']

  #       student.create_address(sitio: row['sitio'], 
  #           barangay: row['barangay'], 
  #           municipality: row['municipality'], 
  #           province: row['province'])
  #     end
  #   end
  # end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(2)
    (3..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      Student.where(id_number: row['ID NUMBER'], first_name: row['FIRST NAME'].upcase, last_name: row['LAST NAME'].upcase).first_or_create! do |s|
      
        s.tag_uid = row['CARD UID']
        s.course_id = Course.find_by(abbreviation: row['COURSE']).id
        s.year_level_id = YearLevel.find_by(name: row['YEAR LEVEL']).id
        s.middle_name = row['MIDDLE NAME']
        s.gender = row['GENDER'].to_s.downcase
        s.birthdate = row['BIRTHDATE']
        s.mobile = row['MOBILE']
        if spreadsheet.last_column > 10
          if (row['MUNICIPALITY'] and row['PROVINCE']).present? 
            Address.create(
              user_id: s.id,
              sitio: row['SITIO'], 
              barangay: row['BARANGAY'], 
              municipality: row['MUNICIPALITY'], 
              province: row['PROVINCE'])
          end
        end
      end
    end
  end
end