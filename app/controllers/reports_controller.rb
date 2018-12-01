class ReportsController < ApplicationController
  before_action :authenticate_user!, :check_subscription!

  def render_pdf
    @course = params[:course_id] if params[:course_id].present?
    @year_level = params[:year_level_id] if params[:year_level_id].present?
    @status = params[:status] if params[:status].present?
    @students = Student.filter(by_course: @course, by_year_level: @year_level, by_status: @status).sort_by(&:reversed_name)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = FilteredStudentsPdf.new(@students, @status, @course, @year_level, view_context)
        send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Students.pdf"
      end
    end
  end

  def render_excel
    @course = params[:course_id] if params[:course_id].present?
    @year_level = params[:year_level_id] if params[:year_level_id].present?
    @status = params[:status] if params[:status].present?
    @title = @status.present? ? "List of #{@status} students" : "List of students"
    @filtered_courses = Settings::Course.order(:name).select {|c| c.students.filter(by_course: @course, by_status: @status).present?}
    @filtered_year_levels = Settings::YearLevel.order(:name).select {|y| y.students.filter(by_year_level: @year_level, by_status: @status).present?}
    @students = Student.filter(by_course: @course, by_year_level: @year_level, by_status: @status).sort_by(&:reversed_name)
    respond_to do |format|
      format.xlsx { render xlsx: "render_excel", disposition: 'inline', filename: @title }
    end
  end

  def export_student_records
    @students = Student.all.sort_by(&:reversed_name)
    respond_to do |format|
      format.xlsx { render xlsx: "export_student_records", disposition: 'inline', filename: "Exported Student Records" }
    end
    authorize :report, :export_student_records?
  end

  def student_template
    respond_to do |format|
      format.xlsx { render xlsx: "student_template", disposition: 'inline', filename: "Student Template" }
    end
  end

end