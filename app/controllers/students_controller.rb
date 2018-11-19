class StudentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json
	autocomplete :student, :full_name, full: true

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
		@search_param = params[:search_param]
		if @search_param.present?
      @filtered = Student.search_by_name(params[:search_param]).sort_by(&:reversed_name)
      @students = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
    else
			@filtered = Student.filter(by_course: @course, by_year_level: @year_level, by_status: @status).sort_by(&:reversed_name)
			@students = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
		end
	end

	def new
    @student = Student.new
    @student.build_address
    authorize @student
  end
  
  def create
    @student = Student.create(create_params)
    authorize @student
    if @student.save
      redirect_to info_student_path(@student), notice: 'Student registered successfully.'
    else
      render :new
    end
  end

  def edit
    @student = Student.find(params[:id])
    authorize @student
    respond_modal_with @student
  end

  def update
    @student = Student.find(params[:id])
    authorize @student
    @student.update_attributes(update_params)
    respond_modal_with @student,
      location: info_student_path(@student)
  end

	def info
		@student = Student.find(params[:id])
    @student_id = Student.find(params[:id])
	end

	private
		def filtering_params(params)
		  params.slice(:course_id, :year_level_id)
		end

    def create_params
      params.require(:student).permit(:id_number, :course_id, :year_level_id,
                :first_name, :middle_name, :last_name, :role, :status,
                :birthdate, :gender, :mobile, :tag_uid,
                address_attributes: [:sitio, :barangay, :municipality, :province])
    end

    def update_params
      params.require(:student).permit(:id_number, :course_id, :year_level_id,
                :first_name, :middle_name, :last_name,
                :birthdate, :gender, :mobile, :tag_uid)
    end
end