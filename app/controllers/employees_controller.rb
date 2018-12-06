class EmployeesController < ApplicationController
  before_action :authenticate_user!, :check_subscription!
  respond_to :html, :json

	def index
		@search_param = params[:search_param]
		if @search_param.present?
      @filtered = Employee.search_by_name(params[:search_param]).sort_by(&:reversed_name)
      @employees = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
    else
			@filtered = Employee.all.sort_by(&:reversed_name)
			@employees = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
		end
	end

	def new
    @employee = Employee.new
    @employee.build_position
    @employee.build_address
    authorize @employee
  end
  
  def create
    @employee = Employee.create(create_params)
    authorize @employee
    if @employee.save
      redirect_to info_employee_path(@employee), notice: 'Employee registered successfully.'
    else
      render :new
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    authorize @employee
    respond_modal_with @employee
  end

  def update
    @employee = Employee.find(params[:id])
    authorize @employee
    @employee.update_attributes(update_params)
    respond_modal_with @employee,
      location: info_employee_path(@employee)
  end

	def info
		@employee = Employee.find(params[:id])
    @employee_id = Employee.find(params[:id])
	end

	private
		def filtering_params(params)
		  params.slice(:course_id, :year_level_id)
		end

    def create_params
      params.require(:employee).permit(:id_number, :first_name, 
                :middle_name, :last_name, :role, :status,
                :birthdate, :gender, :mobile, :rfid_uid,
                address_attributes: [:sitio, :barangay, :municipality, :province],
                position_attributes: [:title])
    end

    def update_params
      params.require(:employee).permit(:id_number,
                :first_name, :middle_name, :last_name,
                :birthdate, :gender, :mobile, :rfid_uid)
    end
end