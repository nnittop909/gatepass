class StudentForm
	include ActiveModel::Model
	attr_accessor :id_number, :course_id,
                :first_name, :middle_name, :last_name,
                :birthdate, :gender, :mobile, 
                :sitio, :barangay, :municipality, :province,
                :tag_uid, :role, :status,
                :full_name, :g_mobile, :relation, 
                :g_sitio, :g_barangay, :g_municipality, :g_province
  validates :id_number, :tag_uid, :role, :course_id, :first_name, :last_name, :full_name, :mobile, :g_mobile, :relation, :municipality, :province, :g_municipality, :g_province, presence: true

  def save 
    if valid?
      ActiveRecord::Base.transaction do
        create_student
      end
    end
  end

  private
    def create_records
      @student = Student.create!(id_number: id_number, course_id: course_id, first_name: first_name, 
        middle_name: middle_name, last_name: last_name, birthdate: birthdate,
        gender: gender, mobile: mobile, tag_uid: tag_uid, role: role, status: status)

      @student.create_address!(sitio: sitio, barangay: barangay,
        municipality: municipality, province: province)

    	@guardian = Guardian.create!(full_name: full_name, mobile: g_mobile)

    	@guardian.create_address!(sitio: g_sitio, barangay: g_barangay, 
        municipality: g_municipality, province: g_province)
    	
      Relationship.create!(relation: relation, user_id: @student.id, guardian_id: @guardian.id)
    end
end