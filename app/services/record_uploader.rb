class RecordUploader
	require 'csv'
  require 'roo'

	def initialize(file)
		@file = file
	end

	def import!
    spreadsheet = Roo::Spreadsheet.open(@file.path)
    header = spreadsheet.row(2)
    (3..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      create_student(row)
    end
  end

  private
  	def create_student(row)
  		student = Student.where(id_number: row['ID NUMBER'], tag_uid: row['CARD UID'], first_name: row['FIRST NAME'].upcase, last_name: row['LAST NAME'].upcase).first_or_create! do |s|
      
        s.course_id = Course.find_by(abbreviation: row['COURSE']).id
        s.year_level_id = YearLevel.find_by(name: row['YEAR LEVEL']).id
        s.middle_name = row['MIDDLE NAME']
        s.gender = row['GENDER'].to_s.downcase
        s.birthdate = Date.parse(row['BIRTHDATE'].to_s) if row['BIRTHDATE'].present?
        s.mobile = row['MOBILE']
      end
      if student.address.blank?
        Address.create(
          user_id: student.id,
          sitio: row['SITIO'], 
          barangay: row['BARANGAY'], 
          municipality: row['MUNICIPALITY'], 
          province: row['PROVINCE'])
      end
  	end
end