class FilteredStudentsPdf < Prawn::Document
  TABLE_WIDTHS = [300, 272]
  TABLE_COLUMNS = [100, 100, 100, 272]
  WITH_STATUS_COLUMNS = [100, 100, 100, 100, 172]
  def initialize(students, status, course, year_level, view_context)
    super(margin: 20, page_size: [612, 1008], page_layout: :portrait)
    @students = students
    @course_id = course 
    @year_level_id = year_level
    @course = Settings::Course.find(course) if course.present?
    @year_level = Settings::YearLevel.find(year_level) if year_level.present?
    @status = status if status.present?
    @view_context = view_context
    heading
    students_table
  end
  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def filtered_by_courses
    Settings::Course.order(:name).select {|c| c.students.filter(by_course: @course_id, by_status: @status).present?}
  end

  def filtered_by_year_levels
    Settings::YearLevel.order(:name).select {|y| y.students.filter(by_year_level: @year_level_id, by_status: @status).present?}
  end

  def year_level_title
    if @year_level.name == "I"
      "FIRST YEAR"
    elsif @year_level.name == "II"
      "SECOND YEAR"
    elsif @year_level.name == "III"
      "THIRD YEAR"
    elsif @year_level.name == "IV"
      "FOURTH YEAR"
    elsif @year_level.name == "V"
      "FIFTH YEAR"
    end
  end

  def title
    if @status.blank?
      if @course.present? and @year_level.blank?
        "LIST OF #{@course.abbreviation} STUDENTS"
      elsif @course.present? and @year_level.present?
        "LIST OF #{@course.abbreviation} - #{@year_level.name} STUDENTS"
      elsif @course.blank? and @year_level.present?
        "LIST OF #{year_level_title} STUDENTS"
      end
    else
      if @status == "suspended"
        "LIST OF #{@status.upcase} STUDENTS"
      elsif @status == "dropped"
        "LIST OF #{@status.upcase} STUDENTS"
      end
    end
  end

  def heading
    text "IFUGAO STATE UNIVERSITY", align: :center, size: 11, style: :bold
    text "Lagawe, Campus", align: :center, size: 10
    move_down 10
    text title, size: 11, align: :center, style: :bold
    move_down 2
    text "As of #{Time.zone.now.strftime('%B %e, %Y')}", size: 9, align: :center
    move_down 4
    stroke_horizontal_rule
    move_down 10
  end

  def students_table
    if @students.blank?
      move_down 10
      text "No Records found.", align: :center
    else
      move_down 10
      if @status.present?
        students_with_record_status_table_data
      else
        students_table_data
      end
    end
  end

  def students_table_data
    header = ["NAME", "ID NUMBER", "GENDER", "ADDRESS"]
    footer = ["", "", "", ""]
    filtered_by_courses.each do |course|
      filtered_by_year_levels.each do |year_level|
        text "#{course.abbreviation} - #{year_level}", size: 9, align: :center, style: :bold
        students_data = Student.filter(by_course: course.id, by_year_level: year_level.id, by_status: @status).sort_by(&:reversed_name).map { |e| [e.reversed_name, e.id_number, e.gender.titleize, e.address_details || "N/A"]}
        table_data = [header, *students_data, footer]
        table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: TABLE_COLUMNS) do
          cells.borders = [:top]
          row(0).font_style = :bold
          column(3).align = :center
        end
        move_down 20
      end
    end
  end

  def students_with_record_status_table_data
    header = ["NAME", "ID NUMBER", "COURSE/YEAR LEVEL", "GENDER", "ADDRESS"]
    footer = ["", "", "", "", ""]
    students_data = Student.filter(by_status: @status).sort_by(&:reversed_name).map { |e| [e.reversed_name, e.id_number, e.course_and_year, e.gender.titleize, e.address_details || "N/A"]}
        table_data = [header, *students_data, footer]
        table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: WITH_STATUS_COLUMNS) do
          cells.borders = [:top]
          row(0).font_style = :bold
          column(4).align = :center
        end
        move_down 20
  end
end
