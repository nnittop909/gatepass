class StudentImport
  include ActiveModel::Model
  require 'roo'
  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
    # student_attributes = Student.column[1..11].each { |name, value| send("")}
    # address_attributes = Address.column_names[2..5]
    # student_address_attributes = student_attributes + address_attributes
  end

  def persisted?
    false
  end

  def save
    if imported_students.map(&:valid?).all?
      imported_students.each(&:save!)
      true
    else
      imported_students.each_with_index do |student, index|
        student.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_students
    @imported_students ||= load_imported_students
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_students
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = Student.find_by(id_number: row['id_number']) || Student.new
      student.attributes = row.to_hash
      # student = Student.where(id_number: row['id_number'], first_name: row['first_name'], last_name: row['last_name']).first_or_create do |s|
      
      #   s.course_id = Course.find_by(abbreviation: row['course']).id
      #   s.year_level_id = YearLevel.find_by(name: row['year_level']).id
      #   s.middle_name = row['middle_name']
      #   s.gender = row['gender'].to_s.downcase
      #   s.birthdate = row['birthdate']
      #   s.mobile = row['mobile']
      #   s.tag_uid = row['card_uid']
        
      #   s.create_address(sitio: row['sitio'], 
      #       barangay: row['barangay'], 
      #       municipality: row['municipality'], 
      #       province: row['province'])
      # end
      student
    end
  end
end