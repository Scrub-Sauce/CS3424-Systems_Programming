#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main (int argc, char **argv){
    
    pid_t cpid[6];
    int i, j, numOfCommands = 0,  numOfArguments[6];
    char argumentBuffer[6][20][90];
    char *commands[20];
    numOfArguments[0] = 0;

    for(i = 0; i < argc-1; i++){
        if(numOfCommands <= 5){
            if(strcmp(argv[i+1], ",") != 0 && i != argc - 2){
                strcpy(argumentBuffer[numOfCommands][numOfArguments[numOfCommands]], argv[i+1]);
                numOfArguments[numOfCommands]++;
            }else if(i == argc - 2){
                strcpy(argumentBuffer[numOfCommands][numOfArguments[numOfCommands]], argv[i+1]);
                numOfArguments[numOfCommands]++;
                numOfCommands++;
            }else{
                numOfCommands++;
                numOfArguments[numOfCommands] = 0;
            }
        }else{
            fprintf(stderr, "USAGE: ./assign8 <command1> [command2...command6]\n");
            return EXIT_FAILURE;
        }
    }       
        
    for(i  = 0; i < numOfCommands; i++){
        switch(cpid[i] = fork()){
            case -1:
                fprintf(stderr, "ERROR: Fork error");
                exit(1);
            case 0:
                for(j = 0; j < numOfArguments[i]; j++){
                    commands[j] = argumentBuffer[i][j];
                    commands[numOfArguments[i]] = NULL;
                }
                printf("PID: %d, PPID: %d, CMD: %s\n", getpid(), getppid(), argumentBuffer[i][0]);
                execvp(argumentBuffer[i][0], commands);
        }
    }

    while(wait(NULL) != -1);

    return EXIT_SUCCESS;
}
