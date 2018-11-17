five_year_course = CourseDuration.where(name: '5-Year Course', duration: 5).first_or_create
four_year_course = CourseDuration.where(name: '4-Year Course', duration: 4).first_or_create
two_year_course = CourseDuration.where(name: '2-Year Course', duration: 2).first_or_create
one_semester_course = CourseDuration.where(name: '1-Semester Course', duration: 0.5).first_or_create

Course.where(
	name:            'Bachelor of Science in Computer Engineering', 
	abbreviation:    "BSCpE",
	course_duration: five_year_course
).first_or_create

Course.where(
	name:            'Bachelor of Science in Civil Engineering', 
	abbreviation:    "BSCE",
	course_duration: five_year_course
).first_or_create

Course.where(
	name:            'Bachelor of Science in Accountancy', 
	abbreviation:    "BSAC",
	course_duration: five_year_course
).first_or_create

Course.where(
	name:            'Bachelor of Science in Business Administration', 
	abbreviation:    "BSBA",
	course_duration: four_year_course
).first_or_create

Course.where(
	name: 'Bachelor of Science in Industrial Technology', 
	abbreviation: "BSIT",
	course_duration: four_year_course
).first_or_create

Course.where(
	name: 'Bachelor of Technical Teacher Education', 
	abbreviation: "BTTE",
	course_duration: four_year_course
).first_or_create