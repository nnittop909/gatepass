class EmployeesController < ApplicationController
	autocomplete :employees, :full_name, full: true

  def autocomplete
    @employees = Employee.all
    @names = @employees.map { |m| m.full_name }
    render json: @names
  end

	def index
		@full_name = params[:full_name]
		if @full_name.present?
      @filtered = Employee.order(:last_name).search_by_name(params[:full_name])
      @employees = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
    else
			@employees = Employee.order(:last_name).page(params[:page]).per(30)
		end
	end
end