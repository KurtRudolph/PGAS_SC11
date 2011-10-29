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

#define NUM_VERTICES 128
#define NUM_EDGES 64
/* Shared pointers which point to a shared object */

//shared int *shared p;

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

//shared vertexlist;
//shared edgelist;


void initialize(); 

int main( int argc, char* argv[]){
  assert( THREADS % 2 == 0);  
  
    
  initialize(); 
  upc_barrier; 
if( MYTHREAD == 1){
  vertex_t *temp;
  temp = head;
  while(temp->next != NULL){
    temp = temp->next;
    printf( " p = %d \n", temp->value[0]);
  }
}
return 0;
}

void initialize(){ 
 /* if( MYTHREAD == 0){
    p = upc_alloc( sizeof( vertex_t));
    p->value = upc_alloc( sizeof( int)); 
    *(p->value) = 2;
  }*/

  int i;  
  srand(time(NULL));
  vertex_t *temp;
  
  if( MYTHREAD == 0) {
    head = tail = upc_alloc( sizeof( vertex_t));
    head->value = upc_alloc( sizeof( int));
    *(head->value) = 22;//rand()%NUM_EDGES; 
    head->next = NULL;
    head->prev = NULL; 
  }  
 
  assert(tail != NULL); assert( head != NULL); assert (tail == head);
  upc_barrier; 
  for( i= 0; i< NUM_VERTICES; i++){
    if( (i% THREADS) == MYTHREAD){
      temp = head;
      head = upc_alloc( sizeof( vertex_t));
      head->value = upc_alloc( sizeof( int));
      *(head->value) = i;//rand()%NUM_EDGES; 
      head->next = temp;
      head->prev = NULL;
    }
    upc_barrier;
  }
}
