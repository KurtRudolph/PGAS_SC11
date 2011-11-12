shared int *shared vectorA; 
shared int *shared vectorB; 

void initilize() {
/*initize vectorA and vectorB with affinity 
        distributed accross threads*/}
	
void randomAccess() {
  int i;
  for( i = 0; i < NUM_ACCESSES; i++)
    vectorA[rand()% THREADS][rand()% VECTOR_SIZE] = 
        vectorA[rand()% THREADS][rand()% VECTOR_SIZE] *
        vectorB[rand()% THREADS][rand()% VECTOR_SIZE];}

    
