class EmployeeRecordUploader
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
      create_employee(row)
    end
  end

  private
  	def create_employee(row)
  		employee = Employee.where(id_number: row['ID NUMBER'], rfid_uid: row['RFID UID'], first_name: row['FIRST NAME'].upcase, last_name: row['LAST NAME'].upcase).first_or_create! do |s|
      
        s.middle_name = row['MIDDLE NAME']
        s.gender = parse_gender(row)
        s.birthdate = parse_birth_date(row)
        s.mobile = parse_mobile_number(row)
      end
      if employee.position.blank?
        Position.create(
          user_id: employee.id,
          title: row['POSITION TITLE']
        )
      end
      if employee.address.blank?
        Address.create(
          user_id: employee.id,
          sitio: row['SITIO'], 
          barangay: row['BARANGAY'], 
          municipality: row['MUNICIPALITY'], 
          province: row['PROVINCE'])
      end
  	end

    def parse_mobile_number(row)
      if row['MOBILE'].present?
        if row['MOBILE'].to_s.split("").count == 10
          [0, row['MOBILE']].join("").to_s
        else
          row["MOBILE"]
        end
      end
    end

    def parse_birth_date(row)
      Date.parse(row['BIRTHDATE'].to_s) if row['BIRTHDATE'].present?
    end

    def parse_gender(row)
      if row['GENDER'].to_s.first.downcase == "m"
        "male"
      elsif row['GENDER'].to_s.first.downcase == "f"
        "female"
      end
    end
end