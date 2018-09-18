class StudentsController < ApplicationController
  before_action :authenticate_user!
	autocomplete :students, :full_name, full: true

  def autocomplete
    @students = Student.all
    @names = @students.map { |m| m.full_name }
    render json: @names
  end

	def index
		@courses = Course.all
		@year_levels = YearLevel.all
		@course = params[:course_id] if params[:course_id].present?
		@year_level = params[:year_level_id] if params[:year_level_id].present?
    @status = params[:status] if params[:status].present?
		@full_name = params[:full_name]
		if @full_name.present?
      @filtered = Student.sort_by(&:reversed_name).search_by_name(params[:full_name])
      @students = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
    else
			@filtered = Student.filter(by_course: @course, by_year_level: @year_level, by_status: @status).sort_by(&:reversed_name)
			@students = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
		end
	end

  def report
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

  def export
    @course = params[:course_id] if params[:course_id].present?
    @year_level = params[:year_level_id] if params[:year_level_id].present?
    @status = params[:status] if params[:status].present?
    @title = @status.present? ? "List of #{@status} students" : "List of students"
    @filtered_courses = Course.order(:name).select {|c| c.students.filter(by_course: @course, by_status: @status).present?}
    @filtered_year_levels = YearLevel.order(:name).select {|y| y.students.filter(by_year_level: @year_level, by_status: @status).present?}
    @students = Student.filter(by_course: @course, by_year_level: @year_level, by_status: @status).sort_by(&:reversed_name)
    respond_to do |format|
      format.xlsx { render xlsx: "export", disposition: 'inline', filename: @title }
    end
  end

  def import
    begin
      Student.import(params[:file])
      redirect_to students_url, notice: 'Students Imported'
    rescue
      redirect_to students_url, notice: 'Invalid Excel File.'
    end
  end

  def full_template
    respond_to do |format|
      format.xlsx { render xlsx: "full_template", disposition: 'inline', filename: "Student Import Template-1" }
    end
  end

  def initial_template
    respond_to do |format|
      format.xlsx { render xlsx: "initial_template", disposition: 'inline', filename: "Student Import Template-2" }
    end
  end

	def new
    @student = Student.new
    @student.build_address
  end
  
  def create
    @student = Student.new(create_params)
    if @student.save
      redirect_to info_student_path(@student), notice: 'Student registered successfully.'
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(update_params)
      redirect_to info_student_path(@student), notice: 'Student updated successfully.'
    else
      render :edit
    end
  end

  def update_options
    @student = Student.find(params[:id])
  end

	def info
		@student = Student.find(params[:id])
	end

	private
		def filtering_params(params)
		  params.slice(:course_id, :year_level_id)
		end

    def create_params
      params.require(:student).permit(:id_number, :course_id, :year_level_id,
                :first_name, :middle_name, :last_name, :role, :status,
                :birthdate, :gender, :mobile, :email, :tag_uid,
                address_attributes: [:sitio, :barangay, :municipality, :province])
    end

    def update_params
      params.require(:student).permit(:id_number, :course_id, :year_level_id,
                :first_name, :middle_name, :last_name,
                :birthdate, :gender, :mobile, :email, :tag_uid)
    end

		# def create_params
  #     params.require(:student_form).permit(:id_number, :course_id,
  #               :first_name, :middle_name, :last_name,
  #               :birthdate, :gender, :mobile, 
  #               :sitio, :barangay, :municipality, :province,
  #               :tag_uid, :role, :status,
  #               :full_name, :g_mobile, :relation, 
  #               :g_sitio, :g_barangay, :g_municipality, :g_province)
  # 	end

    def status_update_params
      params.require(:student).permit(:status)
    end
end