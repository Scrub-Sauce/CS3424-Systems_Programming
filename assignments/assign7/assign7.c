#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "assign7.h"

int main(int argc, char ** argv){
    FILE * pcoursesDB;
    char inputBuffer[MAIN_BUF_SIZE];
       
    if((pcoursesDB = fopen(COURSES_DB_FILE, "rb+")) == NULL){
            if((pcoursesDB = fopen(COURSES_DB_FILE, "wb+")) == NULL){
                fprintf(stderr, "ERROR: Unable to create or read course.dat file");
                exit(1);
        }
    }

    menuPrompt();
    while(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) != NULL){
        char userChoice;
        if(sscanf(inputBuffer, "%c", &userChoice) != 1){
            fprintf(stderr, "ERROR: Could not read input stream\n");
            exit(1);
        }

        switch(toupper(userChoice)){
            case 'C':
                createRecord(pcoursesDB);
                menuPrompt();
                break;
            case 'U':
                updateRecord(pcoursesDB);
                menuPrompt();
                break;
            case 'R':
                readRecord(pcoursesDB);
                menuPrompt();
                break;
            case 'D':
                deleteRecord(pcoursesDB);
                menuPrompt();
                break;
            default:
                fprintf(stderr, "ERROR: Invalid Option\n");
                menuPrompt();
        }
    }
    fclose(pcoursesDB);
    return EXIT_SUCCESS;
}

void createRecord(FILE *pcoursesDB){
    COURSE newCourse, tmpCourse;
    unsigned courseNumber;
    char inputBuffer[MAIN_BUF_SIZE];

    printf("Enter course number: ");
    if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
        fprintf(stderr, "ERROR: Fatal input error");
        exit(1);
    }
    if(sscanf(inputBuffer, "%u", &courseNumber) != 1){
        fprintf(stderr, "ERROR: Fatal input Error");
        exit(1);
    }

    if(fseek(pcoursesDB, courseNumber * sizeof(COURSE), SEEK_SET) == -1){
        fprintf(stderr, "ERROR: fseek error");
        exit(1);
    }

    if(fread(&tmpCourse, sizeof(COURSE), 1L, pcoursesDB) != 1 || tmpCourse.courseHours <= 0){
        printf("Enter course name: ");
        if(fgets(newCourse.courseName, MAIN_BUF_SIZE, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal input Error");
            exit(1);
        }
        newCourse.courseName[strlen(newCourse.courseName)-1] = '\0';
    

        printf("Enter course schedule: ");
        if(fgets(newCourse.courseSched, SCHED_BUF_SIZE + 2, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal input Error");
            exit(1);
        }   
        newCourse.courseSched[strlen(newCourse.courseSched)-1] = '\0';

        printf("Enter credit hours: ");
        if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal Input Error");
            exit(1);
        }
        if(sscanf(inputBuffer, "%u", &newCourse.courseHours) != 1){
            fprintf(stderr, "ERROR: Fatal input Error");
            exit(1);
        }

        printf("Enter student enrollment: ");
        if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal Input Error");
            exit(1);
        }
        if(sscanf(inputBuffer, "%u", &newCourse.courseSize) != 1){
            fprintf(stderr, "ERROR: Fatal input Error");
            exit(1);
        }

        if(fseek(pcoursesDB, courseNumber * sizeof(COURSE), SEEK_SET) == -1){
            fprintf(stderr, "ERROR: fseek error");
            exit(1);
        }
    
        if(fwrite(&newCourse, sizeof(COURSE), 1L, pcoursesDB) != 1){
            fprintf(stderr, "ERROR: fwrite error");
            exit(1);
        }
    }else{
        fprintf(stderr, "ERROR: course already exists\n");
    }
}

void updateRecord(FILE *pcoursesDB){
    COURSE updatedCourse;
    unsigned courseNumber, tmp;
    char inputBuffer[MAIN_BUF_SIZE];

    printf("Enter course number: ");
    if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
        fprintf(stderr, "ERROR: Fatal input error");
        exit(1);
    }

    if(sscanf(inputBuffer, "%u", &courseNumber) != 1){
        fprintf(stderr, "ERROR: Fatal input error");
        exit(1);
    }
    
    if(fseek(pcoursesDB, courseNumber * sizeof(COURSE), SEEK_SET) == -1){
        fprintf(stderr, "ERROR: fseek error");
        exit(1);
    }
    if(fread(&updatedCourse, sizeof(COURSE), 1L, pcoursesDB) != 1 || updatedCourse.courseHours <= 0){
        fprintf(stderr, "ERROR: course not found\n");
    }else{
        printf("Enter updated course name: ");
        if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal input error");
            exit(1);
        }
        inputBuffer[strlen(inputBuffer) - 1] = '\0';
        if(strlen(inputBuffer) > 0){
           strcpy(updatedCourse.courseName, inputBuffer);
        }

        printf("Enter updated course schedule: ");
        if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal input error");
            exit(1);
        }
        inputBuffer[strlen(inputBuffer) - 1] = '\0';
        if(strlen(inputBuffer) > 0){
            strcpy(updatedCourse.courseSched, inputBuffer);
        }

        printf("Enter updated credit hours: ");
        if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal input error");
            exit(1);
        }
        if(sscanf(inputBuffer, "%u", &tmp) == 1){
            updatedCourse.courseHours = tmp;
        }
        
        
        printf("Enter updated student enrollment: ");
        if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
            fprintf(stderr, "ERROR: Fatal input error");
            exit(1);
        }
        if(sscanf(inputBuffer, "%u", &tmp) ==1){
            updatedCourse.courseSize = tmp;
        }
        if(fseek(pcoursesDB, courseNumber * sizeof(COURSE), SEEK_SET) == -1){
            fprintf(stderr, "ERROR: fseek error");
        }

        if(fwrite(&updatedCourse, sizeof(COURSE), 1L, pcoursesDB) != 1){
            fprintf(stderr, "ERROR: fwrite error");
            exit(1);
        }
    }
}

void readRecord(FILE *pcoursesDB){
    COURSE activeCourse;
    unsigned courseNumber;
    char inputBuffer[MAIN_BUF_SIZE];
    
    printf("Enter course number: "); 
    if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
        fprintf(stderr, "ERROR: Fatal input error");
        exit(1);
    }
    if(sscanf(inputBuffer, "%u", &courseNumber) != 1){
        fprintf(stderr, "ERROR: Fatal input error");
        exit(1);
    }

    if(fseek(pcoursesDB, courseNumber * sizeof(COURSE), SEEK_SET) == -1){
        fprintf(stderr, "ERROR: fseek error");
        exit(1);
    }

    if(fread(&activeCourse, sizeof(COURSE), 1L, pcoursesDB) != 1 || activeCourse.courseHours <= 0){
        fprintf(stderr, "ERROR: Class does not exist\n");
    }else{
        printf("Course Number: %u\nCourse Name: %s\nScheduled days: %s\nCredit Hours: %u\nEnrolled Students: %u\n", courseNumber, activeCourse.courseName, activeCourse.courseSched, activeCourse.courseHours, activeCourse.courseSize);
    }
}

void deleteRecord(FILE *pcoursesDB){
    COURSE deleteCourse;
    unsigned courseNumber;
    char inputBuffer[MAIN_BUF_SIZE];

    printf("Enter course number: ");
    if(fgets(inputBuffer, MAIN_BUF_SIZE, stdin) == NULL){
        fprintf(stderr, "ERROR: Fatal input error");
        exit(1);
    }
    if(sscanf(inputBuffer, "%u", &courseNumber) != 1){
        fprintf(stderr, "ERROR: Fatal input error");
    }

    if(fseek(pcoursesDB, courseNumber * sizeof(COURSE), SEEK_SET) == -1){
        fprintf(stderr, "ERROR: fseek error");
        exit(1);
    }

    if(fread(&deleteCourse, sizeof(COURSE), 1L, pcoursesDB) != 1 || deleteCourse.courseHours <= 0){
        fprintf(stderr, "ERROR: course not found\n");
    }else{
        strcpy(deleteCourse.courseName, "");
        strcpy(deleteCourse.courseSched, "");
        deleteCourse.courseHours = 0;
        deleteCourse.courseSize = 0;
        if(fseek(pcoursesDB, courseNumber * sizeof(COURSE), SEEK_SET) == -1){
            fprintf(stderr, "ERROR: fseek error");
            exit(1);
        }

        if(fwrite(&deleteCourse, sizeof(COURSE), 1L, pcoursesDB) != 1){
            fprintf(stderr, "ERROR: fwrite error");
            exit(1);
        }
        printf("course number was successfully deleted.\n");
    }
}

void menuPrompt(){
    printf("Enter one of the following actions or press CTRL-D to exit.\nC - create a new course record\nU - update an existing course record\nR - read an existing course record\nD - delete an existing course record\n");
}

