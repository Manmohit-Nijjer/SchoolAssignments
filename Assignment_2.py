# This Assignment was where we learned key skills in running querys in postgres and using those querys we are able to generate info. 
# In the context of this assignment this query is to generate a gpa grade result depending on students in postgres and their grades 

import psycopg2

def calculate_gpa(grades):
    # Convert numeric grades to a 4.0 scale
    total_points = 0
    for grade in grades:
        if grade >= 90:
            total_points += 4.0
        elif grade >= 80:
            total_points += 3.0
        elif grade >= 70:
            total_points += 2.0
        elif grade >= 60:
            total_points += 1.0
        else:
            total_points += 0.0
    return total_points / len(grades)

def main():
    with psycopg2.connect("dbname= user= password=") as conn:
        with conn.cursor() as cur:
            # Query to get student names and IDs
            cur.execute("""
                SELECT 
                    s.student_id AS id, 
                    s.name 
                FROM 
                    assignment_1.students s
                WHERE 
                    s.student_id BETWEEN 1000 AND 1020
            """)
            students = cur.fetchall()

            # Print header
            print(f"{'Student Name':<20} {'Student ID':<10} {'GPA':<5}")

            for student in students:
                student_id, student_name = student

                # Query to get grades for the student
                cur.execute("""
                    SELECT 
                        f.grade_number AS grade 
                    FROM 
                        assignment_1.final_grades f 
                    WHERE  
                        f.id_number = %s
                """, (student_id,))
                grades = cur.fetchall()

                # Ensure the student has at least two grades
                if len(grades) >= 2:
                    grades = [grade[0] for grade in grades]
                    gpa = calculate_gpa(grades)
                    print(f"{student_name:<20} {student_id:<10} {gpa:.2f}")

if __name__ == "__main__":
    main()
