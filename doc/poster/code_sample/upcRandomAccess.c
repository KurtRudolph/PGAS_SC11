#define N 10000
shared int *shared vectorA; 
shared int *shared vectorB; 

void initilize() {
    /*initize vectorA and vectorB with affinity 
        distributed accross threads*/}
void randomAccess() {
 int i;
 upc_forall( i= 0; i< N; i++, i) 
    {vectorA[rand()%THREADS][rand()%N]*
        vectorB[rand()%THREADS][rand()%N];}}



    
