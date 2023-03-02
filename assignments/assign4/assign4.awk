#!/usr/bin/awk -f

END{
    printf("s|\\[\\[dept_code\\]\\]|%s|g\n", dept_code);
    printf("s|\\[\\[dept_name\\]\\]|%s|g\n", dept_name);
    printf("s|\\[\\[course_name\\]\\]|%s|g\n", course_name);
    printf("s|\\[\\[course_start\\]\\]|%s|g\n", course_start);
    printf("s|\\[\\[course_end\\]\\]|%s|g\n", course_end);
    printf("s|\\[\\[credit_hours\\]\\]|%d|g\n", credit_hours);
    printf("s|\\[\\[num_students\\]\\]|%d|g\n", num_students);
    printf("s|\\[\\[course_num\\]\\]|%d|g\n", course_num);
    printf("s|\\[\\[date\\]\\]|%s|g\n", date);
}
