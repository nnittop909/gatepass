class Student < User
	
  include Filterable
  require 'roo'
  belongs_to :course
  belongs_to :year_level
	validates :id_number, :tag_uid, :course_id, :year_level_id, presence: true
	validates :id_number, :tag_uid, uniqueness: true

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

  # def open_spreadsheet
  #   case File.extname(file.original_filename)
  #   when ".csv" then Csv.new(file.path, nil, :ignore)
  #   when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  #   when ".xlsx" then Roo::Excelx.new(file.path)
  #   else 
  #     raise "Unknown file type: #{file.original_filename}"
  #   end
  # end

  def self.import(file)
    case File.extname(file.original_filename)
    when ".csv" then spreadsheet = Csv.new(file.path, nil, :ignore)
    when ".xls" then spreadsheet = Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then spreadsheet = Roo::Excelx.new(file.path)
    else 
      raise "Unknown file type: #{file.original_filename}"
    end
    header = spreadsheet.row(1)
    ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      complete_address = (row['SITIO'] || row['BARANGAY'] || row['BARANGAY'] || row['MUNICIPALITY'])
      Student.where(id_number: row['ID NUMBER'], first_name: row['FIRST NAME'], last_name: row['LAST NAME']).first_or_create do |s|
      
        s.course_id = Course.find_by(abbreviation: row['COURSE']).id
        s.year_level_id = YearLevel.find_by(name: row['YEAR LEVEL']).id
        s.first_name = row['FIRST NAME']
        s.middle_name = row['MIDDLE NAME']
        s.last_name = row['LAST NAME']
        s.gender = row['GENDER'].to_s.downcase
        s.birthdate = row['BIRTHDATE']
        s.mobile = row['MOBILE']
        s.tag_uid = row['CARD UID']
        if complete_address.present?
          s.create_address(sitio: row['SITIO'], 
            barangay: row['BARANGAY'], 
            municipality: row['MUNICIPALITY'], 
            province: row['PROVINCE'])
        end
      end
    end
  end
end