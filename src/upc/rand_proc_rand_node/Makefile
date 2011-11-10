MYTARGET = rand_proc_rand_node

SRCS   = $(MYTARGET).upc
OBJS   = $(SRCS:.upc=.o)

UPCC   = upcc
UPCC_FLAGS = --network=smp

$(MYTARGET):
	$(UPCC) -o $@ $(UPCC_FLAGS) $(SRCS)
$(MYTARGET)_st%: 
	$(UPCC) -o $@ $(UPCC_FLAGS) $(SRCS)

clean:
	-rm -f $(OBJS) $(MYTARGET) $(MYTARGET)_st* *.out *.err
