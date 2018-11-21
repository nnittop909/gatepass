module SystemSettings
	class CoursesController < ApplicationController
		before_action :authenticate_user!
		respond_to :html, :json

		def new
			@course = Settings::Course.new
			respond_modal_with @course
		end

		def create
			@course = Settings::Course.create(course_params)
			respond_modal_with @course,
				location: settings_url
		end

		def edit
			@course = Settings::Course.find(params[:id])
			respond_modal_with @course
		end

		def update
			@course = Settings::Course.find(params[:id])
			@course.update(course_params)
			respond_modal_with @course,
				location: settings_url,
				notice: "Course Updated Successfully"
		end

		private
			def course_params
				params.require(:settings_course).permit(:name, :abbreviation, :course_duration_id)
			end
	end
end