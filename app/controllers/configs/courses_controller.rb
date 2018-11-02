module Configs
	class CoursesController < ApplicationController
		before_action :authenticate_user!

		def new
			@course = Course.new
		end

		def create
			@course = Course.create!(course_params)
		end

		def edit
			@course = Course.find(params[:id])
		end

		def update
			@course = Course.find(params[:id])
			@course.update!(course_params)
		end

		private
			def course_params
				params.require(:course).permit(:name, :abbreviation)
			end
	end
end