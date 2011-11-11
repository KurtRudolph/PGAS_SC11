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

//#define NUM_VERTICES 128
int64_t NUM_VERTICES;
/* Shared pointers which point to a shared object */

ticks start;
ticks end;
shared int random_variable;

shared struct vertex{
  shared int *value; 
  shared struct vertex *next;
  shared struct vertex *prev;
}typedef vertex_t;

vertex_t *shared head;
vertex_t *shared tail;

shared struct edge{
  vertex_t *vertexA;
  vertex_t *vertexB;
}typedef edge_t;

void initialize(); 
void traverse();
void clean_up();

int main( int argc, char* argv[]){
  assert( THREADS % 2 == 0);  
  
  char *pEnd;
  NUM_VERTICES = 32*(int)strtod(argv[1], NULL);
    
  initialize(); 
  traverse();
  clean_up();
  upc_barrier;
  return 0;
}

void initialize(){ 
  int i;  
  srand( time( NULL));
  vertex_t *temp;
  
  if( MYTHREAD == 0) {
    head = tail = upc_alloc( sizeof( vertex_t));
    head->value = upc_alloc( sizeof( int));
    *(head->value) = rand(); 
    head->next = NULL;
    head->prev = NULL; 
  }  
  upc_barrier; 
  assert(tail != NULL); assert( head != NULL); assert (tail == head);
  upc_barrier; 
  for( i= 0; i< NUM_VERTICES; i++){
    if(MYTHREAD == 0)
      random_variable = rand();
    upc_barrier;
    if( (random_variable % THREADS) == MYTHREAD){
      //printf( "MYTHREAD %d\n", MYTHREAD);
      temp = tail;
      tail = upc_alloc( sizeof( vertex_t));
      tail->value = upc_alloc( sizeof( int));
      *(tail->value) = rand(); 
      tail->next = NULL;
      tail->prev = temp;
      temp->next = tail;
    }
    upc_barrier;
  }
}

void traverse(){
  upc_barrier; 
  if( MYTHREAD == 0){
    vertex_t *temp;
    temp = head;

    start = getticks();
    while(temp->next != NULL){
      temp = temp->next;
    }
    end = getticks();    

    FILE *fp;
    fp = fopen( "./results", "a");
    fprintf( fp, "%d, %d \n", NUM_VERTICES, (int64_t)elapsed( end, start));
    fclose(fp);
  }
}

void clean_up(){
  upc_barrier; 
  if( MYTHREAD == 0){
    vertex_t *temp;
    vertex_t *clean;
    temp = head;

    while(temp->next != NULL){
      clean = temp;
      temp = temp->next;
      upc_free( clean->value);
      upc_free( clean);
    }
  }
} 
