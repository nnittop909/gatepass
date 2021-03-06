class GuardianForm
	include ActiveModel::Model
	attr_accessor :student_id, 
                :first_name, 
                :middle_name, 
                :last_name, 
                :mobile, 
                :relation, 
                :sitio, 
                :barangay, 
                :municipality, 
                :province
  validates :first_name, 
            :last_name, 
            :relation, 
            :municipality, 
            :province, 
             presence: true
  
  def initialize(attr = {})
    if !attr["id"].nil?
      @student = Student.find(attr["id"])
      @relationship = @student.relationship
      @guardian = @student.guardian
      @address = @guardian.address

      self.student_id = attr[:student_id].nil? ? @student.id : attr[:student_id]
      self.first_name = attr[:first_name].nil? ? @guardian.first_name : attr[:first_name]
      self.middle_name = attr[:middle_name].nil? ? @guardian.middle_name : attr[:middle_name]
      self.last_name = attr[:last_name].nil? ? @guardian.last_name : attr[:last_name]
      self.mobile =  attr[:mobile].nil? ? @guardian.mobile : attr[:mobile]

      self.relation =  attr[:relation].nil? ? @relationship.relation : attr[:relation]
      self.sitio =  attr[:sitio].nil? ? @address.sitio : attr[:sitio]
      self.barangay =  attr[:barangay].nil? ? @address.barangay : attr[:barangay]
      self.municipality =  attr[:municipality].nil? ? @address.municipality : attr[:municipality]
      self.province =  attr[:province].nil? ? @address.province : attr[:province]
     else
       super(attr)
     end
  end

  def save 
    if valid?
      ActiveRecord::Base.transaction do
        save_form
      end
    end
  end

  def update
    if valid?
      ActiveRecord::Base.transaction do
        update_form
      end
    end
  end

  def persisted?
    @guardian.nil? ? false : @guardian.persisted?
  end

  def id
    @student.nil? ? nil : @student.id
  end

  
  def save_form
    student = Student.find(student_id)
    guardian = Guardian.where(first_name: first_name.upcase, last_name: last_name.upcase).first_or_create do |g|
      g.middle_name = middle_name.upcase
      g.mobile =      mobile
    end
    student.create_relationship(relation: relation, guardian: guardian)
    guardian.create_address(sitio: sitio, barangay: barangay, 
      municipality: municipality, province: province)
  end

  def update_form
    @student.guardian.update(first_name: first_name, middle_name: middle_name, 
      last_name: last_name, mobile: mobile)
    @student.relationship.update(relation: relation)
    @student.guardian.address.update(sitio: sitio, barangay: barangay, 
      municipality: municipality, province: province)
  end
end