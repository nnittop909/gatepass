class User < ApplicationRecord

  include PgSearch
  require 'csv'
  require 'roo'

  pg_search_scope :search_by_name, :against => [:full_name, :first_name, :last_name]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address, dependent: :destroy
  has_one :relationship, dependent: :destroy
  has_one :guardian, through: :relationship
  has_one :profile_photo, dependent: :destroy

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :profile_photo
  
  enum role:[:student, :employee, :admin, :developer]
  enum status:[:clear, :suspended, :dropped]
  BLACKLISTED_ROLES = ['admin', 'developer']
  WHITELISTED_ROLES = ['student', 'employee']
  BLACKLISTED_STATUS = ['clear']
  enum gender:[:male, :female]
  
  
  validates :first_name, :last_name, :role, presence: true
  validates_presence_of :id_number, :tag_uid, :course_id, :year_level_id, if: :student?
  validates_uniqueness_of :id_number, :tag_uid, if: :student?
  validates_length_of :mobile, :is => 10, if: :student?
  
  before_save :set_full_name, :set_join_date
  before_validation :set_role, :set_email_password

  delegate :details, to: :address, prefix: true, allow_nil: true

  def student?
    self.class.name == "Student"
  end

  def self.whitelisted_roles
    roles.keys - BLACKLISTED_ROLES
  end

  def self.blacklisted_roles
    roles.keys - WHITELISTED_ROLES
  end

  def self.whitelisted_statuses
    statuses.keys - BLACKLISTED_STATUS
  end

  def order_by_reversed_name
    Student.all.sort_by {|s| s.reversed_name}
  end

  def record_status
    if self.clear? || self.status.nil?
      nil
    elsif self.suspended?
      "SUSPENDED"
    elsif self.dropped?
      "DROPPED"
    end
  end

  def self.types
    %w(Employee Student)
  end
  
  def fullname
  	if self.middle_name.present?
    	"#{first_name.upcase} #{middle_name.first.upcase}. #{last_name.upcase}"
    else
    	"#{first_name.upcase} #{last_name.upcase}"
    end
  end

  def name
  	"#{first_name.upcase}"
  end

  def reversed_name
    if self.middle_name.present?
  	  "#{last_name.upcase}, #{first_name.upcase} #{middle_name.first.upcase}."
    else
      "#{last_name.upcase}, #{first_name.upcase}"
    end
  end

  private

  def set_role
    if self.role.nil?
      if self.class.name == "User"
        self.role = "admin"
      elsif self.class.name == "Student"
        self.role = "student"
      elsif self.role == "Employee"
        self.role = "employee"
      end
    end
  end

  def set_email_password
    if self.student?
      generated_password = Devise.friendly_token.first(8)
      if self.email.blank? and self.password.blank?
        if self.last_name.present? and self.first_name.present?
          rand_num = 3.times.map{ SecureRandom.random_number(9)}.join.to_s
          fname_down = self.last_name.downcase
          lname_down = self.first_name.downcase.first
          self.email = "#{fname_down}.#{lname_down}#{rand_num}@ifsu.com"
      		self.password = generated_password
      		self.password_confirmation = generated_password
      	end
      elsif self.email.present? and self.password.blank?
        self.password = generated_password
        self.password_confirmation = generated_password
      end
    end
  end

  def set_join_date
    if self.join_date.nil?
      openning = Openning.first.openning_date
      self.join_date = openning
    end
  end

  def set_full_name
    self.full_name = fullname.upcase
    self.first_name = first_name.upcase
    self.middle_name = middle_name.upcase if middle_name.present?
    self.last_name = last_name.upcase
  end

end
