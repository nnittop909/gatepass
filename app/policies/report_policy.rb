class ReportPolicy < ApplicationPolicy

  def export_student_records?
  	user.developer?
  end

end