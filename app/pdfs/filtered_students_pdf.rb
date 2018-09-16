class FilteredStudentsPdf < Prawn::Document
  TABLE_WIDTHS = [300, 272]
  TABLE_COLUMNS = [200, 100, 272]
  def initialize(students, status, course, year_level, view_context)
    super(margin: 20, page_size: [612, 1008], page_layout: :portrait)
    @students = students
    @course_id = course if course.present?
    @year_level_id = year_level if year_level.present?
    @course = Course.find(@course_id) if course.present?
    @year_level = YearLevel.find(@year_level) if year_level.present?
    @status = status if status.present?
    @view_context = view_context
    heading
    students_table
  end
  def price(number)
    @view_context.number_to_currency(number, :unit => "P ")
  end

  def filtered_by_courses
    Course.order(:name).select {|c| c.students.filter(by_course: @course_id, by_status: @status).present?}
  end

  def filtered_by_year_levels
    YearLevel.order(:name).select {|y| y.students.filter(by_year_level: @year_level_id, by_status: @status).present?}
  end

  def title
    if @status.blank?
      "LIST OF STUDENTS"
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
      students_table_data
    end
  end

  def students_table_data
    header = ["NAME", "ID NUMBER", "ADDRESS"]
    footer = ["", "", ""]
    filtered_by_courses.each do |course|
      filtered_by_year_levels.each do |year_level|
        text "#{course.abbreviation} - #{year_level}", size: 9, align: :center, style: :bold
        students_data = Student.filter(by_course: course.id, by_year_level: year_level.id, by_status: @status).sort_by(&:reversed_name).map { |e| [e.reversed_name, e.id_number, e.address_details || "N/A"]}
        table_data = [header, *students_data, footer]
        table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: TABLE_COLUMNS) do
          cells.borders = [:top]
          row(0).font_style = :bold
          column(2).align = :center
        end
        move_down 20
      end
    end
  end
end
