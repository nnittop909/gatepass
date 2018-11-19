module Config
	class CoursesController < ApplicationController
		before_action :authenticate_user!
		respond_to :html, :json

		def new
			@course = Course.new
			respond_modal_with @course
		end

		def create
			@course = Course.create(course_params)
			respond_modal_with @course,
				location: settings_url
		end

		def edit
			@course = Course.find(params[:id])
			respond_modal_with @course
		end

		def update
			@course = Course.find(params[:id])
			@course.update(course_params)
			respond_modal_with @course,
				location: settings_url,
				notice: "Course Updated Successfully"
		end

		private
			def course_params
				params.require(:course).permit(:name, :abbreviation, :course_duration_id)
			end
	end
end