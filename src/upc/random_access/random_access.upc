/** 
  * Performs random access of percision vectors to simulate sparce graph
  * operations.  
  * in UPC .  THREADS Should be a power of 2
 **/
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <upc.h>
#include "cycle.h"

//#define VECTOR_SIZE 1024
int64_t VECTOR_SIZE;
//#define NUM_ACCESSES 1024
int64_t NUM_ACCESSES;

ticks start;
ticks end;

shared int *shared vectorA[THREADS];
shared int *shared vectorB[THREADS];
shared int *shared vectorC[THREADS];

void initialize (); 
void random_access();
void clean_up();

int main( int argc, char* argv[]){
  assert( THREADS % 2 == 0);

  char *pEnd;
  VECTOR_SIZE = (int)strtod(argv[1], NULL);
  NUM_ACCESSES = 32*(int)strtod(argv[2], NULL);

  initialize();
  random_access();
  clean_up();
  return 0;
}

void initialize(){
  int i;
  srand( time( NULL) * MYTHREAD);
  vectorA[MYTHREAD] = upc_alloc( sizeof(shared int) * VECTOR_SIZE);
  vectorB[MYTHREAD] = upc_alloc( sizeof(shared int) * VECTOR_SIZE);
  vectorC[MYTHREAD] = upc_alloc( sizeof(shared int) * VECTOR_SIZE);

  for( i= 0; i < VECTOR_SIZE; i++){
    vectorA[MYTHREAD][i] = rand();
    vectorB[MYTHREAD][i] = rand();
    vectorC[MYTHREAD][i] = 0;
  }
 } 

void random_access(){
  int i;
  srand( time( NULL) * MYTHREAD);
  
  upc_barrier;
  if( MYTHREAD == 0)
    start = getticks();

  for( i = 0; i < NUM_ACCESSES; i++)
    vectorA[rand()% THREADS][rand()% VECTOR_SIZE] = 
        vectorA[rand()% THREADS][rand()% VECTOR_SIZE] * vectorB[rand()% THREADS][rand()% VECTOR_SIZE];

  upc_barrier;
  if( MYTHREAD == 0){
    end = getticks();    
    FILE *fp;
    fp = fopen("./results", "a");
    fprintf (fp, "%d, %d, %d \n", VECTOR_SIZE, NUM_ACCESSES, (int64_t)elapsed( end, start));
    fclose(fp);
  }
}

void clean_up(){
  upc_free( vectorA[MYTHREAD]);
  upc_free( vectorB[MYTHREAD]);
  upc_free( vectorC[MYTHREAD]);
}
