class YearLevelUpdater

	def initialize
		@students = Student.all
	end

	def perform!
    @students.each do |student|
      if (student.date_enrolled...Time.now).count.days >= 1.year
        if year_level(student) != duration(student)
          update(student)
        end
      end
    end
  end

  private
	  def duration(student)
	  	student.course.course_duration.duration
	  end

	  def year_level(student)
	  	student.year_level.level
	  end

	  def find_year_level(student)
	  	YearLevel.find_by(level: year_level(student) + 1)
	  end

	  def set_date_enrolled(student)
	  	student.date_enrolled + 1.year
	  end

	  def update(student)
	  	student.update!(
      	year_level: find_year_level(student), 
      	date_enrolled: set_date_enrolled(student)
      )
	  end
end