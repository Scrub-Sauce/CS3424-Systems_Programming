#ifndef _set_h
#define _set_h

#define MAIN_BUF_SIZE 60
#define SCHED_BUF_SIZE 4
#define COURSES_DB_FILE "courses.dat"

typedef struct{
    char courseName[MAIN_BUF_SIZE];
    char courseSched[SCHED_BUF_SIZE];
    unsigned courseHours;
    unsigned courseSize;
} COURSE;

void createRecord(FILE *pcoursesDB);
void updateRecord(FILE *pcoursesDB);
void readRecord(FILE *pcoursesDB);
void deleteRecord(FILE *pcoursesDB);
void menuPrompt();

#endif
